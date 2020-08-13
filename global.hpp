#ifndef GLOBAL_H
#define GLOBAL_H

#include <iostream>
#include <string>
#include <algorithm>
#include <fstream>
#include <filesystem>

#include "emitter.hpp"
#include "parser.hpp"
#include "symtable.hpp"

#define WRITE 		301
#define READ 		302
#define LABEL 		303

extern FILE* yyin;

int yylex_destroy();

#endif