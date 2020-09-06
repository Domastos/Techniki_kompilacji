#ifndef EMITTER_H
#define EMITTER_H

#include <iomanip>
#include <string>
#include "global.hpp"
#include "parser.hpp"



extern int getRelationalOperatorToken(std::string text);
extern int getSignOperatorToken(std::string text);
extern int getMulopOperatorToken(std::string text);

enum Sign : int
    {
        Positive,
        Negative
    };

enum Mulop : int
    {
        Multiply,
        Divide,
        Modulo,
        And
    };

enum RelationOperators : int
{ 
    NotEqual,
    LesserEqual,
    GreaterEqual,
    Greater,
    Equal,
    Lesser
};


class MakeASM {
private:
    std::stringstream stream;
    bool checkType(int input1, int input2);
    std::string genMulopMnemonik(int token);
    std::string genSignMnemonik(int token);
    std::string genRelopMnemonik(int token);

public:
    void writeToStream(std::string str, std::string anotation);
    void writeToStream(std::string str1, std::string str2, std::string anotation);
    void writeToStream(std::string mnemonic, std::string mnemonic_type,
                       std::string dst, std::string anotation);
    void writeToStream(std::string mnemonic, std::string mnemonic_type,
                       std::string l_operand, std::string r_operand, std::string anotation);
    void writeToStream(std::string mnemonic, std::string mnemonic_type,
                       std::string l_operand, std::string r_operand, std::string destination, std::string anotation);

    std::string genOperand(int index);
    std::string genOperandName(int index);
    std::string genMnemonik(int token, int operator_type);
    std::string genMnemonikType(int index);

    std::string genAnotation(std::string mnemonic, std::string mnemonic_type, int lhs, int rhs, int dest);
    std::string genAnotation(std::string mnemonic, std::string mnemonic_type, int lhs, int dest);
    std::string genAnotation(std::string mnemonic, std::string mnemonic_type, int dest);
    std::string genAnotation(std::string anotation);

    void genAssemblerCode(int token, int input1, bool isValue1, int input2, bool isValue2);
    void genAssignment(int lhs, int rhs);
    int genExpression(int op_type, int op, int lhs, int rhs);
    void writeToFile();
};
#endif