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
    void setIsReference(bool ref_condition);
    void setIsGlobal(bool global_condition);
    void setAddress(int sAdress);

    int getToken() const;
    int getType() const;
    int getAddress() const;
    std::string getName() const;
};

class SymbolTable {
//static dla tego ze Symtable bedzie 1(zamiast extern)
public:
    SymbolTable();
    static std::vector<Symbol> vectorOfSymbols; //vector of variables ma adresy do objektów
    static void insertSymbol(Symbol);
    static void cleanStack();
    static int getAdress(std::string Adress);
    // static void printSymbolTable();
};


#endif //TK_SYMTABLE_H
