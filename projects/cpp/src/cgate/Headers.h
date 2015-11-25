#pragma once

#include <iostream>
#include <string>
#include <map>
#include <cassert>
#include <memory>
#include <algorithm>
#include <cmath>
using namespace std;

// diagnose what parts of boost are being loaded
#define BOOST_LIB_DIAGNOSTIC

//#include <ql/quantlib.hpp>
//using namespace QuantLib;

// for now let's just use the typedef here
// will take in quantlib later
typedef double Real;

#include <cgate.h>

#ifdef _WIN32
#define WIN32_LEAN_AND_MEAN
#include <Windows.h>
#endif // _WIN32

// todo: cpplinq and rx once they compile

template <typename T> int sign(T val) {
  return (T(0) < val) - (val < T(0));
}