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

bool MakeASM::checkType(int input1, bool isValue1, int input2, bool isValue2){
    int type1 = isValue1? symboltable.getSymbolAtIndex(input1).getToken() : tINT;
    int type2 = isValue2? symboltable.getSymbolAtIndex(input2).getToken() : tINT;
    
    if (type1 != type2){
        if(type1 == tINT && type2 == tREAL) {
            genAssemblerCode(REALTOINT, input1, isValue1, input2, isValue2);
            return true;
        } else if(type1 == tREAL && type2 == tINT) {
            genAssemblerCode(INTTOREAL, input1, isValue1, input2, isValue2);
            return true;
        } else {
            std::cerr << "ERROR: UNSUPORTED TYPE" << std::endl;
            return false;
        }
    }
    return true;
}


void MakeASM::genAssemblerCode(int token, int input1, bool isValue1, int input2, bool isValue2) {
    switch (token)
    {
    case tASSIGN:
        if(checkType(input1, isValue1, input2, isValue2)){

#if DEBUG_EMITTER == 1
            std::cout << "DEBUG_EMITTER: writing mov to a stream" << std::endl;
#endif
            writeToStream("mov");
        }
        break;
    case REALTOINT:
            writeToStream("realtoint");
        break;
    case INTTOREAL:
            writeToStream("inttoreal");
        break;
    default:
        break;
    }
}

void MakeASM::writeToStream(std::string str) {
    stream << '\n'<< str;
}

void MakeASM::writeToFile() {
    outputStream.write(stream.str().c_str(), stream.str().size());
    stream.str(std::string()); //clear
}

