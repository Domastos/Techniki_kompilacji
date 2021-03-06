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

    void setToken(int sToken);
    void setType(int sType);
    void setReferenceCondition(bool ref_condition);
    void setGlobalCondition(bool global_condition);
    void setAddress(int sAdress);
    void setName(std::string sName);

    int getToken() const;
    int getType() const;
    int getAddress() const;
    std::string getName() const;
    std::string getLabel() const;
    bool checkIsGlobal() const;
    bool checkIsReference() const;

};

class SymbolTable {
private:
    bool Global = true;
    void printScope(bool isGlobal);
    void printTableHeader();
    void printSymbolParameters(Symbol symbol);
    std::string tokenToString(int token);
    int currentAddressStack = 0;
    int tempSymbolCounter = 0;
    std::string genTempName();
    std::string genLabelName();
    std::vector<Symbol> vectorOfSymbols; //vector of variables ma adresy do objektów
    int labelCounter = 0;


public:
    SymbolTable();
    void setGlobal(bool val);
    bool getGlobal() const;
    int insertSymbol(Symbol);
    Symbol getSymbolAtIndex(int index);
    int editSymbolAtIndex(int index, int token, int type, int adress);
    int lookUp(std::string name);
    int lookUpAndInsert(std::string name, int token, int type);
    void cleanStack();
    int getAdress(std::string Adress);
    int setSymbolAdress(int Type);
    void printSymbolTable();
};

extern SymbolTable symboltable;


#endif //TK_SYMTABLE_H
