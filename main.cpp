#include "parser.hpp"
#include "symtable.hpp"

int main ()
{
    yyparse();
    SymbolTable::printSymbolTable();
    return 0;
}