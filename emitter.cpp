#include "emitter.hpp"

extern int getRelationalOperatorToken(std::string text)
{   
    std::string val = text;

    if(val == "<>") 
        return  RelationOperators::NotEqual;
    else if(val == "<=") 
        return  RelationOperators::LesserEqual;
    else if(val == ">=") 
        return  RelationOperators::GreaterEqual;
    else if(val == ">")  
        return RelationOperators::Greater;
    else if(val == "=")  
        return RelationOperators::Equal;
    else if(val == "<")  
        return RelationOperators::Lesser;
    else
        return -1;
}