#include "symtable.hpp"

vector<VariableInf> SymbolTable::vectorOfSymbols;

void SymbolTable::insertVariable(VariableInf){

}

void SymbolTable::cleanStack(){

}

int SymbolTable::getAdress(string ID){
        int adress = 0;
        for (long unsigned int i=0; i<vectorOfSymbols.size(); i++) {
            if (ID == vectorOfSymbols[i].name) {
                break;
            }
            adress += vectorOfSymbols[i].size;
        }
        return adress;
}

void SymbolTable::printSymbolTable(){
    for (long unsigned int i=0; i<vectorOfSymbols.size(); i++){
        cout << vectorOfSymbols[i].name << std::setw(6) << vectorOfSymbols[i].size << endl;
    }
}