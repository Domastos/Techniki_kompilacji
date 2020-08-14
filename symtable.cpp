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
void Symbol::setToken(int sToken){token = sToken;}
void Symbol::setType(int sType){type = sType;}
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

void SymbolTable::setGlobal(bool val){ Global = val;}
bool SymbolTable::getGlobal() const {return Global;}

int SymbolTable::insertSymbol(Symbol symbol){
    symbol.setGlobalCondition(Global);
    vectorOfSymbols.push_back(symbol);
    return 0;
}

int SymbolTable::editSymbolAtIndex(int index, int token, int type, int adress){
    vectorOfSymbols[index].setToken(token);
    vectorOfSymbols[index].setToken(type);
    vectorOfSymbols[index].setToken(adress);
    return 0;
}

int SymbolTable::lookUp(std::string name){

#if DEBUG == 1
    std::cout << "DEBUG: Starting lookup" << std::endl;
#endif

    int index = (int) (vectorOfSymbols.size() - 1);
    for(; index>=0; index--){
        if(vectorOfSymbols[index].getName() == name)
            return index;
    }

#if DEBUG == 1
    std::cout << "DEBUG: No identifier with name " << name << " found" << std::endl;
#endif
    return 0;
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

// int SymbolTable::setSymbolAdress(int type) {
//     switch (type)
//     {
//     case tINT:
//         setSymbolAdress
//         break;
    
//     default:
//         break;
//     }
// }

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
#if DEBUG == 1
    std::cout << "DEBUG: size of symtable: " << vectorOfSymbols.size() << std::endl;
#endif

    printTableHeader();
    for(auto &sym : vectorOfSymbols){
        if(sym.getToken() != tIDENTIFIER){
            std::cout << counter << std::setw(3) << '|';
            printScope(sym.checkIsGlobal());
            printSymbolParameters(sym);
            counter++;
        }
    }
}