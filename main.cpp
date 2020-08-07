#include "global.hpp"

static bool has_suffix(const std::string &str, const std::string &suffix);
static std::string getFileOutputName(int argc, char *argv[]);

extern vector<int> Identifiers;

int main(int argc, char *argv[])
{   
    FILE *pascal_file;
    std::string pascal_suffix = ".pas";

    if(argc<2)
    {
        std::cerr<<"Error: wrong argument count."<<std::endl;
        return -1;
    }

    if (!has_suffix(argv[1], pascal_suffix))
    {
        std::cerr<<"Error: not Pascal file. Please give file with .pas suffix"<<std::endl;
        return -1;
    }
    

    pascal_file = fopen(argv[1], "r");

    if(!pascal_file)
    {
        std::cerr<<"Error: file not found"<<std::endl;
        return -1;
    }

    yyparse();
    SymbolTable::printSymbolTable();
    return 0;
}

static bool has_suffix(const std::string &str, const std::string &suffix)
{
    return str.size() >= suffix.size() &&
           str.compare(str.size() - suffix.size(), suffix.size(), suffix) == 0;
}

static std::string getFileOutputName(int argc, char *argv[]) {
	if (argc == 2) {
		return std::string(argv[1]);
	} else if (argc > 2) {
		return std::string(argv[2]);
	} else {
		return "output";
	}
}





