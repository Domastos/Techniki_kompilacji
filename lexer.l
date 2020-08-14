%option noyywrap
%option noinput
%option nounput

%{  
    #include "parser.hpp"
    #include "emitter.hpp"
    int tokenval;
    int lineno;
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
END_PROGRAM        .{1}


%%

{PROGRAM}   {return tPROGRAM;}

{BEGIN}     {return tBEGIN;}

{END}       {return tEND;}

{IF}        {return tIF;}

{THEN}      {return tTHEN;}

{ELSE}      {return tELSE;}

{RELATIONAL_OPERATOR}      {
                           yylval = getRelationalOperatorToken(std::string(yytext));
                           return tRELATIONAL_OPERATOR;
                           }

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

{SIGN}      {yylval = getSignOperatorToken(std::string(yytext));
             return tSIGN;}

{MULOP}     {yylval = getMulopOperatorToken(std::string(yytext));
             return tMULOP;}

":="        {return tASSIGN;}

{ID}        {if(!symboltable.lookUp(yytext))
                symboltable.insertSymbol(Symbol(yytext, tIDENTIFIER, 0));
            return tIDENTIFIER;}

{DIGITS}    {if(!symboltable.lookUp(yytext))
                symboltable.insertSymbol(Symbol(yytext, tNUMBER, tINT));
            return tNUMBER;}

{NUMBER}    {if(!symboltable.lookUp(yytext))
                symboltable.insertSymbol(Symbol(yytext, tNUMBER, tREAL));
            return tNUMBER;}

{COMMENT}   {/*DO NOTHING*/}

{SPACE}     {/*DO NOTHING*/}

{NEWLINE}   {lineno++;}

{END_PROGRAM}   {return *yytext;}

%%


