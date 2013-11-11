#include "headers.h"
#include "FutInfoRepl.hpp"
#include "FullOrderLog.hpp"

enum OrderAction
{
  OrderActionDelete,
  OrderActionAdd,
  OrderActionReduce
};

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

double powersOf10[] = { 1.0, 10.0, 100.0, 1000.0, 10000.0, 100000.0, 1000000.0, 10000000.0 };

double stringToDouble(string& s)
{
  // if the string is empty, just return 0.0
  if (s.empty()) return 0.0;

  auto dotPos = s.find('.');
  s.erase(s.begin() + dotPos);
  return _atoi64(s.c_str())/powersOf10[s.length() - dotPos] ;
}

double bcdToDouble(char* bcd)
{
  int64_t intpart;
  int8_t scale;
  cg_bcd_get(reinterpret_cast<void*>(bcd), &intpart, &scale);
  return (double)intpart / powersOf10[(size_t)scale];
}

class OrderBook
{
  map<Real, int> bids;
  map<Real, int> asks;
public:
  void AddBid(Real price, int volume)
  {
    bids[price] += volume;
  }
  void RemoveBid(Real price, int volume)
  {
    bids[price] -= volume;
    if (bids[price] == 0)
      bids.erase(price);
  }
  void AddAsk(Real price, int volume)
  {
    asks[price] += volume;
  }
  void RemoveAsk(Real price, int volume)
  {
    asks[price] -= volume;
    if (asks[price] == 0)
      asks.erase(price);
  }
  Real GetBestBid()
  {
    if (bids.empty()) return 0;
    else return bids.rbegin()->first;
  }
  Real GetBestAsk()
  {
    if (asks.empty()) return 0;
    else return asks.begin()->first;
  }
  Real GetPrice()
  {
    Real bid = GetBestBid();
    Real ask = GetBestAsk();
    if (bid == 0 && ask == 0)
      return 0;
    else if (bid != 0 && ask != 0)
      return 0.5 * (bid+ask);
    else
      return bid + ask;
  }
  void ProcessOrder(bool bid, bool increase, Real price, int volume)
  {
    map<Real,int>& bucket = bid ? bids : asks;
    if (increase)
      bucket[price] += volume;
    else {
      bucket[price] -= volume;
      assert(bucket[price] >= 0);
      if (bucket[price] == 0)
        bucket.erase(price);
    }
  }
};

bool quit = false;

map<int, FutureInfo::fut_instruments> futureInfo;
map<int, OrderBook> orderBooks;

CG_RESULT fullOrderLogCallback(cg_conn_t* conn, cg_listener_t* listener, cg_msg_t* msg, void* data)
{
  switch (msg->type)
  {
  case CG_MSG_STREAM_DATA:
    cg_msg_streamdata_t* streamData = (cg_msg_streamdata_t*)msg;
    if (streamData->msg_index == FullOrderLog::orders_log_index)
    {
      FullOrderLog::orders_log* ol = reinterpret_cast<FullOrderLog::orders_log*>(msg->data);
      OrderBook& o = orderBooks[ol->isin_id];
      bool bid = ol->dir == 1;
      if (!(ol->status & OrderStatusNonSystem))
      {
        switch (ol->action)
        {
        case OrderActionAdd:
          o.ProcessOrder(bid, true, bcdToDouble(ol->price), ol->amount);
          break;
        case OrderActionDelete:
          o.ProcessOrder(bid, false, bcdToDouble(ol->price), ol->amount);
          break;
        case OrderActionReduce:
          o.ProcessOrder(bid, false, bcdToDouble(ol->price), ol->amount);
          break;
        }
        cout << futureInfo[ol->isin_id].name << " bid " <<
          o.GetBestBid() << " ask " << o.GetBestAsk() << endl;
      }
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

  cg_env_open("ini=qf101.ini;key=11111111");
  cg_conn_t* conn = NULL;
  cg_conn_new(connStr, &conn);

  cg_listener_t* futInfoListener;
  cg_lsn_new(conn, futInfo, &futInfoCallback, 0, &futInfoListener);

  cg_listener_t* fullOrderLogListener;
  cg_lsn_new(conn, fullOrderLog, &fullOrderLogCallback, 0, &fullOrderLogListener);

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
      cg_conn_open(conn, 0);
    } 
    else if (state == CG_STATE_ACTIVE)
    {
      cg_conn_process(conn, 1, 0);
      cg_lsn_getstate(futInfoListener, &state);
      switch (state)
      {
      case CG_STATE_CLOSED:
        cg_lsn_open(futInfoListener, 0);
        break;
      case CG_STATE_ERROR:
        cg_lsn_close(futInfoListener);
        break;
      }      
      cg_lsn_getstate(fullOrderLogListener, &state);
      switch (state)
      {
      case CG_STATE_CLOSED:
        cg_lsn_open(fullOrderLogListener, 0);
        break;
      case CG_STATE_ERROR:
        cg_lsn_close(fullOrderLogListener);
        break;
      }
    }
  }

cleanup:
  if (futInfoListener != NULL)
  {
    cg_lsn_close(futInfoListener);
    cg_lsn_destroy(futInfoListener);
  }
  if (conn != NULL)
    cg_conn_destroy(conn);
  cg_env_close();
  cout << "Press a key to exit" << endl;
  getchar();
  return 0;
}