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

    for (const auto & entry : std::filesystem::directory_iterator(path))
        std::cout << entry.path() << std::endl;

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

    yyin = fopen("Tests.txt", "r");
    yyparse();
    SymbolTable::printSymbolTable();

    infile.close(); //zamyka printowany w konsoli plik
    fclose(yyin); //zamyka plik odczytuwany parserem
    return 0;
}




