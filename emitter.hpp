#ifndef EMITTER_H
#define EMITTER_H

#include <string>
#include "global.hpp"

extern int getRelationalOperatorToken(std::string text);

enum RelationOperators : int
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



#endif