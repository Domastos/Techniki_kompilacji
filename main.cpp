#include "parser.hpp"
#include "symtable.hpp"

#include <fstream>
#include <filesystem>

extern vector<int> Identifiers;

extern "C" int yylex();
extern "C" FILE *yyin; //otwarcie pliku zewnęcznego

int main ()
{   
    // string name;
    // std::cout << "Enter filename: ";
    // std::cin >> name;
    std::string path = "Tests";

    for (const auto & entry : std::filesystem::directory_iterator(path)){
       
        std::cout << entry.path() << std::endl;
        yyin = fopen(entry.path().string().c_str(), "r");
        yyparse();
        fclose(yyin);
        SymbolTable::printSymbolTable();
    }
    
    return 0;
}





