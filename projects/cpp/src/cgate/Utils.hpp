#pragma once

Real powersOf10[] = { 1.0, 10.0, 100.0, 1000.0, 10000.0, 100000.0, 1000000.0, 10000000.0 };

Real stringToDouble(string& s)
{
  // if the string is empty, just return 0.0
  if (s.empty()) return 0;

  auto dotPos = s.find('.');
  s.erase(s.begin() + dotPos);
  return _atoi64(s.c_str())/powersOf10[s.length() - dotPos] ;
}

Real bcdToReal(char* bcd)
{
  int64_t intpart;
  int8_t scale;
  cg_bcd_get(reinterpret_cast<void*>(bcd), &intpart, &scale);
  return (Real)intpart / powersOf10[(size_t)scale];
}

struct BidAndAsk
{
  Real bid, ask;
};