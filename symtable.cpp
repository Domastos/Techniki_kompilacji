#include "symtable.hpp"

SymbolTable symboltable;


Symbol::Symbol(std::string sName, int sToken, int sType)
{
    name = sName;
    token = sToken;
    type = sType;
    isGlobal = false;
	isReference = false;
	address = 0;
}

void Symbol::setReferenceCondition(bool ref_condition){isReference = ref_condition;}
void Symbol::setGlobalCondition(bool global_condition){isGlobal = global_condition;}
void Symbol::setAddress(int sAdress){address = sAdress;}

int Symbol::getToken() const {return token;}
int Symbol::getType() const {return type;}
int Symbol::getAddress() const {return address;}
std::string Symbol::getName() const {return name;}
bool Symbol::checkIsGlobal() const {return isGlobal;}
bool Symbol::checkIsReference() const {return isReference;}


SymbolTable::SymbolTable(){
    Symbol read("read", tPROCEDURE, 0);
	read.setGlobalCondition(true);
	read.setReferenceCondition(false);
	vectorOfSymbols.push_back(read);

	Symbol write("write", tPROCEDURE, 0);
	write.setGlobalCondition(true);
	write.setReferenceCondition(false);
	vectorOfSymbols.push_back(write);

	Symbol lab0("lab0", LABEL, 0);
	lab0.setGlobalCondition(true);
	lab0.setReferenceCondition(false);
	vectorOfSymbols.push_back(lab0);
}

void SymbolTable::insertSymbol(Symbol symbol){
    vectorOfSymbols.push_back(symbol);
}

void SymbolTable::cleanStack(){

}

int SymbolTable::getAdress(std::string ID){
        int adress = 0;
        for (long unsigned int i=0; i<vectorOfSymbols.size(); i++) {
            if (ID == vectorOfSymbols[i].getName()) {
                break;
            }
            adress += vectorOfSymbols[i].getAddress();
        }
        return adress;
}

void SymbolTable::printScope(bool isGlobal){
    if (isGlobal) {
				std::cout << std::setw(8) << "Global" << std::setw(3) << "|";
			} else {
				std::cout << std::setw(8) << "Local" << std::setw(3) << "|";
			}
}

void SymbolTable::printSymbolParameters(Symbol symbol){
    if(symbol.checkIsReference()) {
        std::cout << std::setw(12) << "True" << std::setw(3) << "|";
        std::cout << std::setw(10) << symbol.getName() << std::setw(3) << "|" << std::endl;
    } else if(symbol.getToken() == tNUMBER) {
        std::cout << std::setw(12) << "False" << "|" ;
        std::cout << std::setw(10) << symbol.getName() << std::setw(3) << "|";
        std::cout << symbol.getToken() << "|\t";
        std::cout << symbol.getType() << std::endl;
    } else if(symbol.getToken() == tVAR) {
        std::cout << std::setw(12) << "False" << std::setw(3) << "|" ;
        std::cout << std::setw(10) << symbol.getName() << std::setw(3) << "|" ;
        std::cout << symbol.getToken() << "|\t";
        std::cout << symbol.getType() << "|\t" ;
        std::cout << symbol.getAddress() << std::endl;
    } else if(symbol.getToken() == tPROCEDURE || symbol.getToken() == LABEL) {
        std::cout << std::setw(12) << "False" << std::setw(3) << "|" ;
        std::cout << std::setw(10) << symbol.getName() << std::setw(3) << "|" ;
        std::cout << symbol.getToken() << std::endl;
    } else if(symbol.getToken() == tFUNCTION) {
        std::cout << std::setw(12) << "False" << std::setw(3) << "|" ;
        std::cout << std::setw(10) << symbol.getName() << std::setw(3) << "|" ;
        std::cout << symbol.getToken() << std::endl;
    }
}

void SymbolTable::printTableHeader() {
    std::cout << std::string(100, '-') << std::endl;
    std::cout << std::setw(50) << "Symbol table" << std::endl;
    std::cout << std::string(100, '-') << std::endl;
    std::cout << "N" << std::setw(3) <<"|";
    std::cout << std::setw(8) << "Scope" << std::setw(3) << "|";
    std::cout << std::setw(12) << "isReference" << std::setw(3) << "|";
    std::cout << std::setw(10) << "Name" << std::setw(3) << "|";
    std::cout << "Token" << std::setw(5) << "|\t";
    std::cout << "Type" << std::setw(5) << "|\t";
    std::cout << "Adress" << std::endl;
}

void SymbolTable::printSymbolTable(){
    int counter = 0;
    std::cout << vectorOfSymbols.size() << std::endl;
    printTableHeader();
    for(auto &sym : vectorOfSymbols){
        if(sym.getToken() != tIDENTIFIER) {
            std::cout << counter++ << std::setw(3) << '|';
            printScope(sym.checkIsGlobal());
            printSymbolParameters(sym);

        }

    }
}