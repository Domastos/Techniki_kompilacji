#include "emitter.hpp"

int getRelationalOperatorToken(std::string text)
{   

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
    if(token==tNUMBER || token == LABEL){
        return std::string("#") + std::string(symboltable.getSymbolAtIndex(index).getName()); 
    } 
#if DEBUG_EXPRESSION == 1
    std::cout << "DEBUG_EXPRESSION: operand name: " 
    << symboltable.getSymbolAtIndex(index).getName() << std::endl;
    std::cout << "DEBUG_EXPRESSION: operand Adress: " 
    << symboltable.getSymbolAtIndex(index).getAddress() << std::endl;
    std::cout << "DEBUG_EXPRESSION: operand Adress to string: " 
    << std::to_string(symboltable.getSymbolAtIndex(index).getAddress()) << std::endl;
#endif

    return std::to_string(symboltable.getSymbolAtIndex(index).getAddress());
}

std::string MakeASM::genOperandName(int index){
    return std::string(symboltable.getSymbolAtIndex(index).getName());
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

std::string MakeASM::genMnemonik(int operator_type, int token){
    switch (operator_type)
    {
    case tMULOP:
        return genMulopMnemonik(token);
        break;
    case tSIGN:
        return genSignMnemonik(token);
        break;
    case tRELATIONAL_OPERATOR:
        return genRelopMnemonik(token);
        break;
    case tOR:
        // return gen
        break;
    }
    return "";
}

std::string MakeASM::genMulopMnemonik(int token){
    switch (token)
    {
    case Mulop::Multiply:
        return "\t\tmul";
        break;
    case Mulop::Divide:
        return "\t\tdiv";
        break;
    case Mulop::Modulo:
        return "\t\tmod";
        break;
    case Mulop::And:
        return "\t\tand";
        break;
    default:
        return "";
        break;
    }

}

std::string MakeASM::genSignMnemonik(int token){
    switch (token)
    {
    case Sign::Positive:
        return "\t\tadd";
    case Sign::Negative:
        return "\t\tsub";
    }
    return "";
}

std::string MakeASM::genRelopMnemonik(int token){
    switch (token)
    {
    case RelationOperators::NotEqual:
        return "\t\tjne";
    case RelationOperators::Equal:
        return "\t\tje";
    case RelationOperators::GreaterEqual:
        return "\t\tjge";
    case RelationOperators::Greater:
        return "\t\tjg";
    case RelationOperators::LesserEqual:
        return "\t\tjle";
    case RelationOperators::Lesser:
        return "\t\tjl";
    default:
        return "";
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
        writeToStream("\t\tmov", genMnemonikType(lhs), genOperand(rhs), genOperand(lhs), 
                               genAnotation("\tmov", genMnemonikType(lhs), rhs, lhs));

#if DEBUG_ASSIGNMENT == 1
        std::cout << "writting assignment!" << std::endl;
#endif
    } else {
        if(lhs_type == tINT){
            int temp = symboltable.insertSymbol(Symbol("$", tVAR, tINT));
            writeToStream("\t\trealtoint", genMnemonikType(rhs), genOperand(rhs), genOperand(temp), genAnotation("\trealtoint", "", rhs, temp));
            // writeToStream("\tmov", genMnemonikType(lhs), genOperand(temp), genOperand(lhs), 
            //                    genAnotation("\tmov", genMnemonikType(lhs), temp, lhs));
            genAssignment(lhs, temp);

        } else {
            int temp = symboltable.insertSymbol(Symbol("$", tVAR, tREAL));
            writeToStream("\t\tinttoreal", genMnemonikType(rhs), genOperand(rhs), genOperand(temp), genAnotation("\tinttoreal", "", rhs, temp));
            writeToStream("\t\tmov", genMnemonikType(lhs), genOperand(temp), genOperand(lhs), 
                               genAnotation("\tmov", genMnemonikType(lhs), temp, lhs));

    // writeToStream("\tmov", ".i", genOperand(rhs), genOperand(lhs), genAnotation("\tmov", genMnemonikType(lhs), rhs, lhs));
        }
    }
}

int MakeASM::genExpression(int op_type, int op, int lhs, int rhs){
    int dst = 0;
    int lhs_type = symboltable.getSymbolAtIndex(lhs).getType();
    int rhs_type = symboltable.getSymbolAtIndex(rhs).getType();
    std::string mnemonik = genMnemonik(op_type, op);

    if(lhs_type == tREAL || rhs_type == tREAL){
        if(lhs_type == tINT)
        {
            int temp = symboltable.insertSymbol(Symbol("$", tVAR, tREAL));
            genAssignment(temp, lhs);
            lhs = temp;
        } else if(rhs_type == tINT)
        {
            int temp = symboltable.insertSymbol(Symbol("$", tVAR, tREAL));
            genAssignment(temp, rhs);
            rhs = temp;
        }
        dst = symboltable.insertSymbol(Symbol("$", tVAR, tREAL));
    } 
    else {
        dst = symboltable.insertSymbol(Symbol("$", tVAR, tINT));
    }

    if(op_type == tRELATIONAL_OPERATOR){
       int isTrue = symboltable.insertSymbol(Symbol("$l", LABEL, NONE));
	   int isAfterTrue = symboltable.insertSymbol(Symbol("$l", LABEL, NONE));
       
       writeToStream(mnemonik, genMnemonikType(dst), genOperand(lhs), genOperand(rhs), genOperand(isTrue), genAnotation(mnemonik, genMnemonikType(dst), lhs, rhs, isTrue));

       int FalseValue = symboltable.lookUpAndInsert("0", tNUMBER, tINT);
       genAssignment(dst, FalseValue);       
       writeToStream("\t\tjump.i", genOperand(isAfterTrue), genAnotation(""));
       writeToStream((symboltable.getSymbolAtIndex(isTrue).getName() + ":"),  genAnotation(""));

       int TrueValue = symboltable.lookUpAndInsert("1", tNUMBER, tINT);
       genAssignment(dst, TrueValue);
       writeToStream((symboltable.getSymbolAtIndex(isAfterTrue).getName() + ":"),  genAnotation(""));

    }else{

        writeToStream(mnemonik, genMnemonikType(dst), genOperand(lhs), genOperand(rhs), genOperand(dst), genAnotation(mnemonik, genMnemonikType(dst), lhs, rhs, dst));
    }
    return dst;
}

std::string MakeASM::genAnotation(std::string anotation){
    return "; " + anotation;
}

std::string MakeASM::genAnotation(std::string mnemonic, std::string mnemonic_type, int dest){
    return "\t\t; " + mnemonic + mnemonic_type + " " +  genOperandName(dest);
}

std::string MakeASM::genAnotation(std::string mnemonic, std::string mnemonic_type, int lhs, int dest){
    return "\t; " + mnemonic + mnemonic_type + " " + genOperandName(lhs) + " " + genOperandName(dest);
}

std::string MakeASM::genAnotation(std::string mnemonic, std::string mnemonic_type, int lhs, int rhs, int dest){
    return ";" + mnemonic + mnemonic_type + " " + genOperandName(lhs)
             + " " + genOperandName(rhs) + " " + genOperandName(dest);
}

void MakeASM::writeToStream(std::string str, std::string anotation) {
    stream << '\n'<< str << "\t" << anotation;
}

void MakeASM::writeToStream(std::string str1, std::string str2, std::string anotation) {
    stream << '\n'<< str1 << '\t' << str2 << "\t" << anotation;
}

void MakeASM::writeToStream(std::string mnemonic, std::string mnemonic_type,
                                    std::string dst, std::string anotation){

stream << '\n' << mnemonic << mnemonic_type << '\t' << dst << "\t" << anotation;

}

void MakeASM::writeToStream(std::string mnemonic, std::string mnemonic_type,
                   std::string l_operand, std::string r_operand, std::string anotation){

    stream << '\n' << mnemonic << mnemonic_type << '\t' 
           << l_operand << ", " << r_operand << "\t" << anotation;

}

void MakeASM::writeToStream(std::string mnemonic, std::string mnemonic_type,
                       std::string l_operand, std::string r_operand, std::string destination, std::string anotation) 
{

    stream << '\n' << mnemonic << mnemonic_type << '\t' 
           << l_operand << ", " << r_operand << ", "<< destination << "\t" << anotation;          
}
            

void MakeASM::writeToFile() {
    outputStream.write(stream.str().c_str(), stream.str().size());
    stream.str(std::string()); //clear
}


