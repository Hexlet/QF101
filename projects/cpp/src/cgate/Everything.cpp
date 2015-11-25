#include "headers.h"
#include "FutInfoRepl.hpp"
#include "OptInfoRepl.hpp"
#include "FullOrderLog.hpp"
#include "OrderBook.hpp"
#include "Utils.hpp"
#include "Messages.hpp"
#include "Portfolio.hpp"

// note: behavior different depending on whether order book or
// full order log is being streamed
enum OrderAction
{
  OrderActionDelete,
  OrderActionAdd,
  OrderActionReduce
};

// there are internal statuses used by RTS in addition to those below:
enum OrderStatus
{
  OrderStatusQuote            = 0x01,
  OrderStatusCounter          = 0x02,
  OrderStatusNonSystem        = 0x04,
  OrderStatusEndOfTransaction = 0x1000,
  OrderStatusFillOrKill       = 0x80000,
  OrderStatusResultOfMove     = 0x100000,
  OrderStatusResultOfCancel   = 0x200000,
  OrderStatusResultOfGroupCancel = 0x400000,
  OrderStatusCrossTradeLeftCancel = 0x20000000
};

bool quit = false;

map<int, FutureInfo::fut_instruments> futureInfo;
map<int, OptionInfo::opt_sess_contents> optionInfo;
map<int, OrderBook> orderBooks;
map<int, BidAndAsk> orderBookShapshots;

// assembly of depth-20 order book
CG_RESULT fut20Callback(cg_conn_t* conn, cg_listener_t* listener, cg_msg_t* msg, void* data)
{
  return CG_ERR_OK;
}

CG_RESULT fullOrderLogCallback(cg_conn_t* conn, cg_listener_t* listener, cg_msg_t* msg, void* data)
{
  switch (msg->type)
  {
  case CG_MSG_TN_COMMIT:
    cout << "COMMIT" << endl;
    for (auto i = begin(orderBooks); i != end(orderBooks); ++i)
    {
      // order books that are ready to commit become consistent
      if (i->second.isReadyForAssembly == OrderBook::Ready) 
      {
        i->second.isConsistent = true;
        //i->second.Verify();

        BidAndAsk bidAsk = { i->second.GetBestBid(), i->second.GetBestAsk() };
        orderBookShapshots[i->first] = bidAsk;

        // note: we have *no idea* if this is a futures or options contract, so...
        string name;
        if (futureInfo.find(i->first) != futureInfo.end())
          name = futureInfo[i->first].name;
        else
          name = optionInfo[i->first].name;

        cout << i->first << '\t' << bidAsk.bid << '\t' << bidAsk.ask <<
          '\t' << name << endl;
      }

      // all order books that are almost ready to process become ready
      if (i->second.isReadyForAssembly == OrderBook::AlmostReady)
        i->second.isReadyForAssembly = OrderBook::Ready;
    }
    break;
  case CG_MSG_STREAM_DATA:
    cg_msg_streamdata_t* streamData = (cg_msg_streamdata_t*)msg;
    
    if (streamData->msg_index == FullOrderLog::orders_log_index)
    {
      FullOrderLog::orders_log* ol = reinterpret_cast<FullOrderLog::orders_log*>(msg->data);
      OrderBook& o = orderBooks[ol->isin_id];
      bool bid = ol->dir == 1;
      if (!(ol->status & OrderStatusNonSystem))
      {
        // if we're ready to assemble the order book, do it!
        if (o.isReadyForAssembly == OrderBook::Ready)
        {
          Real price = bcdToReal(ol->price);
          switch (ol->action)
          {
          case OrderActionAdd:
            o.ProcessOrder(bid, true, price, ol->amount, ol->amount_rest);
            break;
          case OrderActionDelete:
            assert(ol->amount > 0 && "deletion on nil order");
            assert(ol->amount_rest == 0 && "order deletion must have remaining amt=0");
            o.ProcessOrder(bid, false, price, ol->amount, ol->amount_rest);
            break;
          case OrderActionReduce:
            o.ProcessOrder(bid, false, price, ol->amount, ol->amount_rest);
            break;
          }
          
          Real bestBid = orderBooks[ol->isin_id].GetBestBid();
          Real bestAsk = orderBooks[ol->isin_id].GetBestAsk();

          // not consistent during assembly!
          o.isConsistent = false;
        } 
        else
        {
          if (ol->status & OrderStatusEndOfTransaction)
          {
            // ok we're almost ready
            o.isReadyForAssembly = OrderBook::AlmostReady;
          } 
        }
      }
    }
    break;
  }

  return CG_ERR_OK;
}

CG_RESULT optInfoCallback(cg_conn_t* conn, cg_listener_t* listener, cg_msg_t* msg, void* data)
{
  using namespace OptionInfo;

  switch (msg->type)
  {
  case CG_MSG_STREAM_DATA:
    cg_msg_streamdata_t* streamData = (cg_msg_streamdata_t*)msg;
    if (streamData->msg_index == opt_sess_contents_index)
    {
      opt_sess_contents* inst = reinterpret_cast<opt_sess_contents*>(streamData->data);
      optionInfo[inst->isin_id] = *inst;
    }
    break;
  }

  return CG_ERR_OK;
}

CG_RESULT futInfoCallback(cg_conn_t* conn, cg_listener_t* listener, cg_msg_t* msg, void* data)
{
  using namespace FutureInfo;

  switch (msg->type)
  {
  case CG_MSG_STREAM_DATA:
    cg_msg_streamdata_t* streamData = (cg_msg_streamdata_t*)msg;
    if (streamData->msg_index == fut_instruments_index)
    {
      fut_instruments* inst = reinterpret_cast<fut_instruments*>(streamData->data);
      futureInfo[inst->isin_id] = *inst;
    }
    break;
  }
  
  return CG_ERR_OK;
}

#ifdef _WIN32
BOOL timeToGo(DWORD)
{
  quit = true;
  return TRUE;
}
#endif

int main()
{
  const char* connStr = "p2tcp://127.0.0.1:4001;app_name=qf101";
  const char* futInfo = "p2repl://FORTS_FUTINFO_REPL";
  const char* fullOrderLog = "p2repl://FORTS_ORDLOG_REPL";
  const char* optInfo = "p2repl://FORTS_OPTINFO_REPL";
  const char* fut20 = "p2repl://FORTS_FUTAGGR20_REPL";

  cg_env_open("ini=qf101.ini;key=11111111");
  cg_conn_t* conn = NULL;
  cg_conn_new(connStr, &conn);

  cg_listener_t *futInfoListener, *optInfoListener, *fullOrderLogListener, *fut20Listener;
  cg_lsn_new(conn, futInfo, &futInfoCallback, 0, &futInfoListener);
  cg_lsn_new(conn, optInfo, &optInfoCallback, 0, &optInfoListener);
  cg_lsn_new(conn, fullOrderLog, &fullOrderLogCallback, 0, &fullOrderLogListener);
  cg_lsn_new(conn, fut20, &fut20Callback, 0, &fut20Listener);

#ifdef _WIN32
  SetConsoleOutputCP(1251);
  SetConsoleCtrlHandler(timeToGo, TRUE);
#endif

  while (!quit)
  {
    uint32_t state;
    cg_conn_getstate(conn, &state);
    if (state == CG_STATE_ERROR)
    {
      cerr << "Failed to connect" << endl;
      cg_conn_close(conn);
    } 
    else if (state == CG_STATE_CLOSED)
    {
      auto result = cg_conn_open(conn, 0);
    } 
    else if (state == CG_STATE_ACTIVE)
    {
      cg_conn_process(conn, 1, 0);

      auto fillOrKillListener = [](cg_listener_t* listener)
      {
        uint32_t s;
        cg_lsn_getstate(listener, &s);
        switch (s)
        {
        case CG_STATE_CLOSED:
          {
            auto result = cg_lsn_open(listener, 0);
          }
          break;
        case CG_STATE_ERROR:
          cg_lsn_close(listener);
          break;
        }
      };

      fillOrKillListener(futInfoListener);
      fillOrKillListener(optInfoListener);
      fillOrKillListener(fullOrderLogListener);
      fillOrKillListener(fut20Listener);
    }
  }

cleanup:
  auto killListener = [](cg_listener_t* listener)
  {
    if (listener != NULL)
    {
      cg_lsn_close(listener);
      cg_lsn_destroy(listener);
    }
  };

  killListener(futInfoListener);
  killListener(optInfoListener);
  killListener(fut20Listener);

  if (conn != NULL)
    cg_conn_destroy(conn);
  cg_env_close();
  cout << "Press a key to exit" << endl;
  getchar();
  return 0;
}