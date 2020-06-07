#ifndef TK_SYMTABLE_H
#define TK_SYMTABLE_H

#pragma once
#include <iostream>
#include <string>
#include <vector>

#include "parser.hpp"

using namespace std;

enum RelationOperator : int
{
    NotEqual,
    LesserEqual,
    GreaterEqual,
    Greater,
    Equal,
    Lesser
};

enum Sign : int
{
    Positive,
    Negative
};

enum Mulop : int
{
    Multiply,
    Divide,
    Div,
    Modulo,
    And
};

class VariableInf {
public:
    bool global;
    int size;
    string name;
};

class LabelInf {
public:
    string name;
};

class SymbolTable {
public:
    vector<VariableInf> vectorOfGlobals; //vector of variables ma adresy do objektów globalnych
    vector<VariableInf> vectorOfLocals; //vector of variables ma adresy do objektów lokalnych
    vector<LabelInf> vectorOfLables; //vector of variables ma adresy do labłów
    void insertVariable(VariableInf);
    void cleanStack();
    int getAdress(string Adress);
};



#endif //TK_SYMTABLE_H
