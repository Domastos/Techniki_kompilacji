#ifndef GLOBAL_H
#define GLOBAL_H

#include <iostream>
#include <string>
#include <algorithm>
#include <fstream>
#include <sstream>
#include <filesystem>

#include "emitter.hpp"
#include "parser.hpp"
#include "symtable.hpp"

#define DEBUG       1
#define DEBUG_FACTOR 0
#define DEBUG_EMITTER 1
#define DEBUG_ASSIGNMENT 0


#define WRITE 		301
#define READ 		302
#define LABEL 		303
#define INTTOREAL 	316
#define REALTOINT 	317

#define INT_SIZE    4
#define REAL_SIZE   8

extern std::ofstream outputStream;
extern FILE* yyin;

int yylex_destroy();

#endif