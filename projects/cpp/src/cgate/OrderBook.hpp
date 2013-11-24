#pragma once

class OrderBook
{
  map<Real, int> bids;
  map<Real, int> asks;
public:
  bool isConsistent;

  // important note: the use of these flags is mostly bullshit since,
  // unlike with order log shapshots, we CANNOT build a 100% consistent
  // order log from stream data.
  // we arrive at 100% consistency through the user of amount_rest :)
  enum {
    NotReady,
    AlmostReady,
    Ready
  } isReadyForAssembly;
  
  OrderBook()
  {
    isConsistent = false; // clearly not
    isReadyForAssembly = Ready; // not yet
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
  void ProcessOrder(bool bid, bool increase, Real price, int volume, int amountRest = -1)
  {
    map<Real,int>& bucket = bid ? bids : asks;

    if (amountRest != -1)
    {
      // we're in an 'incomplete market' so take this on faith
      bucket[price] = amountRest;
    }
    else if (increase)
      bucket[price] += volume;
    else {
      bucket[price] -= volume;
    }
    
    if (bucket[price] == 0)
        bucket.erase(price);
  }
  void Verify()
  {
    // check all volumes are > 0
    for_each(begin(bids), end(bids), [](pair<Real,int> bid) { assert(bid.second > 0); });
    for_each(begin(asks), end(asks), [](pair<Real,int> ask) { assert(ask.second > 0); });
  }
};