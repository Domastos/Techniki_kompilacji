#ifndef TK_SYMTABLE_H
#define TK_SYMTABLE_H

#pragma once

#include <iostream>
#include <string>
#include <vector>
#include <iomanip>

#include "global.hpp"



class Symbol {
private:
    bool isReference;
    bool isGlobal;
    int token;
    int type;
    int address;
    std::string name;

public:
    Symbol(std::string name, int token, int type);
    void setReferenceCondition(bool ref_condition);
    void setGlobalCondition(bool global_condition);
    void setAddress(int sAdress);

    int getToken() const;
    int getType() const;
    int getAddress() const;
    std::string getName() const;
    bool checkIsGlobal() const;
    bool checkIsReference() const;

};

class SymbolTable {
private:
    void printScope(bool isGlobal);
    void printTableHeader();
    void printSymbolParameters(Symbol symbol);
//static dla tego ze Symtable bedzie 1(zamiast extern)
public:
    SymbolTable();
    std::vector<Symbol> vectorOfSymbols; //vector of variables ma adresy do objektów
    void insertSymbol(Symbol);
    void cleanStack();
    int getAdress(std::string Adress);
    void printSymbolTable();
};

extern SymbolTable symboltable;


#endif //TK_SYMTABLE_H
