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


std::string MakeASM::genOperand(int index) {
    int token = symboltable.getSymbolAtIndex(index).getToken();
    switch(token){
        case tNUMBER:
            return std::string("#") + std::string(symboltable.getSymbolAtIndex(index).getName());
            break;
        default:
            return std::to_string(symboltable.getSymbolAtIndex(index).getAddress());
    }
    return "";
}

std::string MakeASM::genMnemonikType(int index){
        int type = symboltable.getSymbolAtIndex(index).getType();   
        switch(type){
            case tINT:
                return ".i";
                break;
            case tREAL:
                return ".r";
                break;
            default:
                return ".?";
                break;
        }
}



void MakeASM::genAssignment(int lhs, int rhs){
    int lhs_type = symboltable.getSymbolAtIndex(lhs).getType();
    int rhs_type = symboltable.getSymbolAtIndex(rhs).getType();
    
    std::cout << "generating assignment!" << std::endl;
    std::cout << "lhs_type" << lhs_type << std::endl;
    std::cout << "lhs_name" << symboltable.getSymbolAtIndex(lhs).getName() << std::endl;
    std::cout << "lhs_label" << symboltable.getSymbolAtIndex(lhs).getLabel() << std::endl;
    
    if(lhs_type == rhs_type){
        writeToStream("\tmov", genMnemonikType(lhs), genOperand(lhs), genOperand(rhs));
        std::cout << "writting assignment!" << std::endl;
    } else {
        if(lhs_type == tINT){
            writeToStream("\trealtoint", "", genOperand(lhs), genOperand(rhs));
            std::cout << "writting realtoint" << std::endl;
        } else {
            writeToStream("\tintoreal", "", genOperand(lhs), genOperand(rhs));
            std::cout << "writting inttoreal" << std::endl;
        }
    }
}

void MakeASM::writeToStream(std::string str) {
    stream << '\n'<< str;
}

void MakeASM::writeToStream(std::string mnemonic, std::string mnemonic_type,
                   std::string l_operand, std::string r_operand){

    stream << '\n' << mnemonic << mnemonic_type << '\t' 
           << l_operand << ", " << r_operand;

}

            

void MakeASM::writeToFile() {
    outputStream.write(stream.str().c_str(), stream.str().size());
    stream.str(std::string()); //clear
}

