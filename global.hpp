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

extern FILE* yyin;

int yylex_destroy();

#endif