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
    if(text == "+") 
        return  Sign::Positive;
    else if(text == "-") 
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

bool MakeASM::checkType(int lhs, int rhs) {
    int lhs_type = symboltable.getSymbolAtIndex(lhs).getType();
    int rhs_type = symboltable.getSymbolAtIndex(rhs).getType();

    if(lhs_type != rhs_type) {
        return 1;
    }

    return 0;
}

void MakeASM::genAssignment(int lhs, int rhs){
    int lhs_type = symboltable.getSymbolAtIndex(lhs).getType();
    int rhs_type = symboltable.getSymbolAtIndex(rhs).getType();

#if DEBUG_ASSIGNMENT == 1    
    std::cout << "generating assignment!" << std::endl;
    std::cout << "lhs_type" << lhs_type << std::endl;
    std::cout << "lhs_name" << symboltable.getSymbolAtIndex(lhs).getName() << std::endl;
    std::cout << "lhs_label" << symboltable.getSymbolAtIndex(lhs).getLabel() << std::endl;
#endif


    if(lhs_type == rhs_type){
        writeToStream("\tmov", genMnemonikType(lhs), genOperand(lhs), genOperand(rhs));
    
#if DEBUG_ASSIGNMENT == 1
        std::cout << "writting assignment!" << std::endl;
#endif

    } else {
        if(lhs_type == tINT){
            writeToStream("\trealtoint", "", genOperand(lhs), genOperand(rhs));

#if DEBUG_ASSIGNMENT == 1
            std::cout << "writting realtoint" << std::endl;
#endif

        } else {
            writeToStream("\tintoreal", "", genOperand(lhs), genOperand(rhs));

#if DEBUG_ASSIGNMENT == 1
            std::cout << "writting inttoreal" << std::endl;
#endif
        }
    }
}

int MakeASM::genExpression(std::string op, int lhs, int rhs){
    int dst = 0;
    int lhs_type = symboltable.getSymbolAtIndex(lhs).getType();
    int rhs_type = symboltable.getSymbolAtIndex(rhs).getType();

    if(lhs_type == tREAL || rhs_type == tREAL){
        dst = symboltable.insertSymbol(Symbol("Temp", NONE, tREAL));
        if(lhs_type == tINT){
            int temp = symboltable.insertSymbol(Symbol("Temp", NONE, tREAL));
            genAssignment(temp, lhs);
            lhs = temp;
        } else
        {
            int temp = symboltable.insertSymbol(Symbol("Temp", NONE, tREAL));
            genAssignment(temp, rhs);
            rhs = temp;
        }
    } else {
        dst = symboltable.insertSymbol(Symbol("Temp", NONE, tINT));
    }
    writeToStream(op, genMnemonikType(symboltable.getSymbolAtIndex(dst).getType()),
                                                genOperand(lhs), genOperand(rhs));
    return dst;
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

