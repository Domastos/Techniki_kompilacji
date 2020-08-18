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
{COMMENT}   {/*DO NOTHING*/}

{SPACE}     {/*DO NOTHING*/}

{NEWLINE}  {lineno++;}

{INT}       {yylval = tINT; return tINT;}
{REAL}      {yylval = tREAL; return tREAL;}

{VAR}      {return tVAR;}

{PROGRAM}   {return tPROGRAM;}

{BEGIN}     {return tBEGIN;}

{END}       {return tEND;}

{NOT}       {return tNOT;}

{OR}        {return tOR;}

{IF}        {return tIF;}

{THEN}      {return tTHEN;}

{ELSE}      {return tELSE;}

{DO}        {return tDO;}

{WHILE}     {return tWHILE;}

{FUNCTION}  {return tFUNCTION;}

{PROCEDURE} {return tPROCEDURE;}

{ARRAY}     {return tARRAY;}

{OF}        {return tOF;}

{RELATIONAL_OPERATOR}      {
                           yylval = getRelationalOperatorToken(std::string(yytext));
                           return tRELATIONAL_OPERATOR;
                           }


{SIGN}      {
             yylval = getSignOperatorToken(std::string(yytext));
             return tSIGN;
             }

{MULOP}     {
             yylval = getMulopOperatorToken(std::string(yytext));
             return tMULOP;
             }

":="        {return tASSIGN;}


{ID}        {
            yylval = symboltable.lookUpAndInsert(yytext, tIDENTIFIER, NONE); 
            return tIDENTIFIER;
            }

{DIGITS}    {
            yylval = symboltable.lookUpAndInsert(yytext, tNUMBER, tINT);
            return tNUMBER;
            }

{NUMBER}    {
            yylval = symboltable.lookUpAndInsert(yytext, tNUMBER, tREAL);
            return tNUMBER;
            }

{END_PROGRAM}   {return *yytext;}

%%


