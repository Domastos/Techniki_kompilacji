#include "symtable.hpp"

std::vector<Symbol> SymbolTable::vectorOfSymbols;

Symbol::Symbol(std::string sName, int sToken, int sType)
{
    name = sName;
    token = sToken;
    type = sType;
    isGlobal = false;
	isReference = false;
	address = 0;
}

void Symbol::setIsReference(bool ref_condition){isReference = ref_condition;}

void Symbol::setIsGlobal(bool global_condition){isGlobal = global_condition;}

void Symbol::setAddress(int sAdress){address = sAdress;}


int Symbol::getToken() const {return token;}

int Symbol::getType() const {return type;}

int Symbol::getAddress() const {return address;}

std::string Symbol::getName() const {return name;}


SymbolTable::SymbolTable(){
    Symbol read("read", tPROCEDURE, 0);
	read.setIsGlobal(true);
	read.setIsReference(false);
	vectorOfSymbols.push_back(read);

	Symbol write("write", tPROCEDURE, 0);
	write.setIsGlobal(true);
	write.setIsReference(false);
	vectorOfSymbols.push_back(write);

	Symbol lab0("lab0", LABEL, 0);
	lab0.setIsGlobal(true);
	lab0.setIsReference(false);
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

// void SymbolTable::printSymbolTable(){
//     for (long unsigned int i=0; i<vectorOfSymbols.size(); i++){
//         cout << vectorOfSymbols[i].name << std::setw(6) << vectorOfSymbols[i].size << endl;
//     }
// }