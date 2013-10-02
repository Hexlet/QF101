#include "headers.h"
#include <cgate.h>
#include "FutInfoRepl.c"

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
};

bool quit = false;

CG_RESULT futInfoCallback(cg_conn_t* conn, cg_listener_t* listener, cg_msg_t* msg, void* data)
{
  switch (msg->type)
  {
  case CG_MSG_STREAM_DATA:
    cg_msg_streamdata_t* streamData = (cg_msg_streamdata_t*)msg;
    if (strcmp(streamData->msg_name, "fut_instruments") == 0)
    {
      fut_instruments* inst = reinterpret_cast<fut_instruments*>(streamData->data);
      quit = true;
    }
    break;
  }

  
  return CG_ERR_OK;
}

int main()
{
  const char* connStr = "p2tcp://127.0.0.1:4001;app_name=qf101";
  const char* futInfo = "p2repl://FORTS_FUTINFO_REPL";

  cg_env_open("ini=qf101.ini;key=11111111");
  cg_conn_t* conn = NULL;
  cg_conn_new(connStr, &conn);

  cg_listener_t* futInfoListener;
  cg_lsn_new(conn, futInfo, &futInfoCallback, 0, &futInfoListener);

  while (!quit)
  {
    uint32_t state;
    cg_conn_getstate(conn, &state);
    if (state == CG_STATE_ERROR)
    {
      cerr << "Failed to connect" << endl;
      cg_conn_close(conn);
    } else if (state == CG_STATE_CLOSED)
    {
      cg_conn_open(conn, 0);
    } else if (state == CG_STATE_ACTIVE)
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

  return 0;
}