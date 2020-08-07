#ifndef TK_SYMTABLE_H
#define TK_SYMTABLE_H

#pragma once

#include <iostream>
#include <string>
#include <vector>
#include <iomanip>

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
//static dla tego ze Symtable bedzie 1(zamiast extern)
public:
    static vector<VariableInf> vectorOfSymbols; //vector of variables ma adresy do objektów
    static void insertVariable(VariableInf);
    static void cleanStack();
    static int getAdress(string Adress);
    static void printSymbolTable();
};


#endif //TK_SYMTABLE_H
