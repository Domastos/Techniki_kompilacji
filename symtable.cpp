#include "symtable.hpp"

void SymbolTable::insertVariable(VariableInf){

}

void SymbolTable::cleanStack(){

}

int SymbolTable::getAdress(string ID){
        int adress = 0;
        for (int i=0; i<vectorOfSymbols.size(); i++) {
            if (ID == vectorOfSymbols[i].name) {
                break;
            }
            adress += vectorOfSymbols[i].size;
        }
        return adress;
}

void SymbolTable::printSymbolTable(){
    for (int i=0; i<vectorOfSymbols.size(); i++){
        cout << vectorOfSymbols[i].name << " " << vectorOfSymbols[i].size << endl;
    }
}