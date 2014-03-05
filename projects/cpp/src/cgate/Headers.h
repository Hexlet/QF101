#ifndef headers_h
#define _headers_h

#include <iostream>
#include <string>
#include <map>
#include <cassert>
using namespace std;

#include <ql/quantlib.hpp>
using namespace QuantLib;

#include <cgate.h>

#ifdef _WIN32
#define WIN32_LEAN_AND_MEAN
#include <Windows.h>
#endif // _WIN32

// todo: cpplinq and rx once they compile
#include <cpprx/rx.hpp>

#endif // !headers_h
