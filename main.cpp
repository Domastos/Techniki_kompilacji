#include "parser.hpp"
#include "symtable.hpp"
#include <fstream>
extern vector<int> Identifiers;

extern "C" int yylex();
extern "C" FILE *yyin; //otwarcie pliku zewnęcznego

int main ()
{   
    // string name;
    // std::cout << "Enter filename: ";
    // std::cin >> name;
    std::ifstream infile;
    infile.open("Tests.txt");
    if(!infile){
        std::cerr << "No such file in directory" << std::endl;
        return 1;
    }
    std::string line;
    while (std::getline(infile, line))
    {
        std::cout << line << std::endl;
    }
    yyparse();
    SymbolTable::printSymbolTable();
    infile.close();
    return 0;
}
