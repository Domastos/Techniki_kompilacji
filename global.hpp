#ifndef GLOBAL_H
#define GLOBAL_H

#include <iostream>
#include <string>
#include <algorithm>
#include <fstream>
#include <filesystem>

#include "parser.hpp"
#include "symtable.hpp"

extern "C" int yylex();
extern "C" FILE *yyin;

int yylex_destroy();


#endif