#pragma once
#include "Headers.h"

class PortfolioEntry
{
public:
  int isin_id;
  int amount; // + means we're long, - means we're short
  Real price; // price at which we bought or sold

  PortfolioEntry(int isin_id, int amount, Real price)
    : isin_id(isin_id), amount(amount), price(price)
  {
    assert(price != 0);
    assert(amount != 0);
  }
};

class Portfolio
{
  map<int, shared_ptr<PortfolioEntry>> positions;
public:
  void Modify(int isin_id, int amount, Real price)
  {
    // get the pointer to the portfolio entry
    auto existing = positions.find(isin_id);
    if (existing == positions.end())
    {
      positions[isin_id] = make_shared<PortfolioEntry>(isin_id, amount, price);
    }
    else
    {
      auto position = existing->second;
      if (position->amount + amount == 0)
      {
        positions.erase(existing);
      }
      else
      {
        position->amount += amount;

        if (sign(position->amount) == sign(amount))
        {
          position->price = (position->price * position->amount + price * amount) / (position->amount + amount);
        }
      }
    }
  }
};
