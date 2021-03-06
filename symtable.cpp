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
void Symbol::setName(std::string sName){name = sName;}

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
}


void SymbolTable::setGlobal(bool val){ Global = val;}
bool SymbolTable::getGlobal() const {return Global;}

std::string SymbolTable::genTempName() {
    std::string tempName = "$t" + std::to_string(tempSymbolCounter);
    tempSymbolCounter++;
    return tempName;
}

std::string SymbolTable::genLabelName() {
    std::string labelName = "lab" + std::to_string(labelCounter);
    labelCounter++;
    return labelName;
}


int SymbolTable::insertSymbol(Symbol symbol){

    //gen temp symbol
    if(symbol.getName() == "$"){ //zmienic temp na inne
        symbol.setName(genTempName());
        symbol.setAddress(currentAddressStack);
        switch (symbol.getType())
        {
        case tINT:
            currentAddressStack += VarSizes::integer_size;
            break;
        case tREAL:
            currentAddressStack += VarSizes::real_size;
            break;
        }
    } else if(symbol.getName() == "$l"){
        symbol.setName(genLabelName());
    }

#if DEBUG == 1
    std::cout << "DEBUG: adding name " << '\'' << symbol.getName() << '\'' << " to symboltable" << std::endl;
    std::cout << std::string(40, '-') << std::endl;
#endif

    symbol.setGlobalCondition(Global);
    vectorOfSymbols.push_back(symbol);
    return (int) (vectorOfSymbols.size() - 1);
}

Symbol SymbolTable::getSymbolAtIndex(int index){
    return vectorOfSymbols[index];
}

int SymbolTable::editSymbolAtIndex(int index, int token, int type, int adress){
    vectorOfSymbols[index].setToken(token);
    vectorOfSymbols[index].setType(type);
    vectorOfSymbols[index].setAddress(currentAddressStack);
    currentAddressStack += adress;
    return 0;
}

std::string SymbolTable::tokenToString(int token) {
    switch (token)
    {
    case LABEL:
        return "label";
    case tVAR:
		return "var";
	case tNUMBER:
		return "num";
	case tARRAY:
		return "array";
	case tINT:
		return "int";
	case tREAL:
		return "real";
	case tPROCEDURE:
		return "proc";
	case tFUNCTION:
		return "fun";
	case tIDENTIFIER:
		return "id";
	default:
		return "null";
    }
}


int SymbolTable::lookUp(std::string name){

    int index = (int) (vectorOfSymbols.size() - 1);

#if DEBUG == 1
    std::cout << "DEBUG: Starting lookup" << std::endl;
    std::cout << "DEBUG: symtable size: " << vectorOfSymbols.size() << std::endl;
#endif

    for(; index >= 0; index--){
#if DEBUG == 1
        std::cout <<  "DEBUG: cheking at index: " << index << std::endl;
#endif
        if(vectorOfSymbols[index].getName() == name)
            return index;
    }

#if DEBUG == 1
    std::cout << "DEBUG: No identifier with name " << name << " found" << std::endl;
#endif

    return -1;
}

int SymbolTable::lookUpAndInsert(std::string name, int token, int type){
    int val = lookUp(name);

#if DEBUG == 1
    std::cout << "DEBUG: returned val id " << val << " found" << std::endl;
#endif

    if(val == -1)
        val = insertSymbol(Symbol(name, token, type));
    return val;
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
        std::cout << std::setw(12) << "False" << std::setw(3) << "|" ;
        std::cout << std::setw(10) << symbol.getName() << std::setw(3) << "|";
        std::cout << std::setw(8) << tokenToString(symbol.getToken()) << std::setw(3) << "|";
        std::cout << std::setw(8) << symbol.getType() << std::endl;
    } else if(symbol.getToken() == tVAR) {
        std::cout << std::setw(12) << "False" << std::setw(3) << "|" ;
        std::cout << std::setw(10) << symbol.getName() << std::setw(3) << "|" ;
        std::cout << std::setw(8) << tokenToString(symbol.getToken()) << std::setw(3) << "|";
        std::cout << std::setw(8) << symbol.getType() << std::setw(3) << "|" ;
        std::cout << std::setw(8) << symbol.getAddress() << std::endl;
    } else if(symbol.getToken() == tPROCEDURE || symbol.getToken() == LABEL) {
        std::cout << std::setw(12) << "False" << std::setw(3) << "|" ;
        std::cout << std::setw(10) << symbol.getName() << std::setw(3) << "|" ;
        std::cout << std::setw(8) << tokenToString(symbol.getToken()) << std::endl;
    } else if(symbol.getToken() == tFUNCTION) {
        std::cout << std::setw(12) << "False" << std::setw(3) << "|" ;
        std::cout << std::setw(10) << symbol.getName() << std::setw(3) << "|" ;
        std::cout << std::setw(8) << tokenToString(symbol.getToken()) << std::endl;
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
    std::cout << std::setw(8) << "Token" << std::setw(3) << "|";
    std::cout << std::setw(8) << "Type" << std::setw(3) << "|";
    std::cout << std::setw(8) << "Adress" << std::endl;
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