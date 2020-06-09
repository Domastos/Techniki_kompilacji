%option noyywrap
%option noinput
%option nounput

%{
    #include "parser.hpp"
    #include "symtable.hpp"
    int tokenval;
%}


COMMENT     \{[^\{]*\}
SPACE       [ \t\r]+
NEWLINE     [\n]
PROGRAM     "program"
BEGIN       "begin"
END         "end"
IF          "if"
THEN        "then"
ELSE        "else"
VAR         "var"
INT         "integer"
REAL        "real"
ARRAY       "array"
OF          "of"
FUNCTION    "function"
PROCEDURE   "procedure"
WHILE       "while"
DO          "do"
OR          "or"
NOT         "not"

RELATIONAL_OPERATOR  <>|<=|>=|>|=|<
SIGN                 \+|-
MULOP                \*|\/|(div)|(mod)|(and)

DIGIT               [0-9]
DIGITS              {DIGIT}+
OPTIONAL_FRACTION   (\.{DIGITS})?
OPTIONAL_EXPONENT  ([Ee]([+-]?){DIGITS})?
NUMBER             {DIGITS}{OPTIONAL_FRACTION}{OPTIONAL_EXPONENT}

LETTER             [a-zA-Z]
ID                 {LETTER}({LETTER}|{DIGIT})*
END_PROGRAM        [\(\)\,\;\:\.\[\]]{1}


%%

{PROGRAM}   {return tPROGRAM;}

{BEGIN}     {return tBEGIN;}

{END}       {return tEND;}

{IF}        {return tIF;}

{THEN}      {return tTHEN;}

{ELSE}      {return tELSE;}

{RELATIONAL_OPERATOR}     {std::string val = std::string(yytext);
             if(val == "<>") yylval = RelationOperator::NotEqual;
             if(val == "<=") yylval = RelationOperator::LesserEqual;
             if(val == ">=") yylval = RelationOperator::GreaterEqual;
             if(val == ">") yylval = RelationOperator::Greater;
             if(val == "=") yylval = RelationOperator::Equal;
             if(val == "<") yylval = RelationOperator::Lesser;
             return tRELATIONAL_OPERATOR;}

{VAR}       {return tVAR;}


{INT}       {return tINT;}

{REAL}      {return tREAL;}

{ARRAY}     {return tARRAY;}

{OF}        {return tOF;}

{FUNCTION}  {return tFUNCTION;}

{PROCEDURE} {return tPROCEDURE;}

{WHILE}     {return tWHILE;}

{DO}        {return tDO;}

{OR}        {return tOR;}

{NOT}       {return tNOT;}

{SIGN}      {std::string val = std::string(yytext);
             if(val== "+") yylval = Sign::Positive;
             if(val== "-") yylval = Sign::Negative;
             return tSIGN;}

{MULOP}     {std::string val = std::string(yytext);
             if(val == "*") yylval = Mulop::Multiply;
             if(val == "/") yylval = Mulop::Divide;
             if(val == "div") yylval = Mulop::Div;
             if(val == "mod") yylval = Mulop::Modulo;
             if(val == "and") yylval = Mulop::And;
             return tMULOP;}

{ID}        { VariableInf variableInf;
              variableInf.global = 1;
              variableInf.size = tIDENTIFIER;
              variableInf.name = string(yytext);
              SymbolTable::vectorOfSymbols.push_back(variableInf);

              return tIDENTIFIER;}

":="        {return tASSIGN;}

{NUMBER}    {return tNUMBER;}

{COMMENT}   {/*DO NOTHING*/}

{SPACE}     {/*DO NOTHING*/}

{NEWLINE}   {/*DO NOTHING*/}

{END_PROGRAM}   {return *yytext;}

%%


