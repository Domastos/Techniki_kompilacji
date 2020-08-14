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

#define WRITE 		301
#define READ 		302
#define LABEL 		303

extern std::ofstream outputStream;
extern FILE* yyin;

int yylex_destroy();

#endif