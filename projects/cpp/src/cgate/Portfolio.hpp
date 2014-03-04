#ifndef Portfolio_hpp
#define Portfolio_hpp

#include <map>
#include <ql/qldefines.hpp>
using namespace QuantLib;

class Portfolio
{
  class InstrumentPosition
  {
  public:
    int isin_id;
    int underlying_isin_id; // for derivative instruments
    int amount; // + means we're long, - means we're short
    Real price; // price at which we bought or sold

    InstrumentPosition(int isin_id, int amount, Real price, int underlying_isin_id = -1)
      : isin_id(isin_id), amount(amount), price(price), underlying_isin_id(underlying_isin_id)
    {
      assert(price != 0);
      assert(amount != 0);
    }
  };
  map<int, InstrumentPosition> positions;
public:

};

#endif