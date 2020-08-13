#include "emitter.hpp"

int getRelationalOperatorToken(std::string text)
{   
    enum RelationOperators : int
    { 
        NotEqual,
        LesserEqual,
        GreaterEqual,
        Greater,
        Equal,
        Lesser
    };

    if(text == "<>") 
        return  RelationOperators::NotEqual;
    else if(text == "<=") 
        return  RelationOperators::LesserEqual;
    else if(text == ">=") 
        return  RelationOperators::GreaterEqual;
    else if(text == ">")  
        return RelationOperators::Greater;
    else if(text == "=")  
        return RelationOperators::Equal;
    else if(text == "<")  
        return RelationOperators::Lesser;
    else
        return -1;
}

int getSignOperatorToken(std::string text)
{   
    enum Sign : int
    {
        Positive,
        Negative
    };

    if(text == "<>") 
        return  Sign::Positive;
    else if(text == "<=") 
        return  Sign::Negative;
    else  
        return -1;
}

int getMulopOperatorToken(std::string text){

    enum Mulop : int
    {
        Multiply,
        Divide,
        Modulo,
        And
    };

    if(text == "*") 
        return  Mulop::Multiply;
    else if(text == "/" || text == "div") 
        return  Mulop::Divide;
    else if(text == "mod")  
        return Mulop::Modulo;
    else if(text == "and")  
        return Mulop::And;
    else
        return -1;
}

