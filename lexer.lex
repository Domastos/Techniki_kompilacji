%option noyywrap
%option noinput
%option nounput

%{
    #include "parser.hpp"
    #include "symtable.hpp"
    int tokenval;
%}

SPACE  [ \t\r\n]+
PROGRAM "program"
BEGIN  "begin"
END    "end"
IF     "if"
THEN   "then"
ELSE   "else"
VAR    "var"
INT    "integer"
REAL   "real"
RELOP  <>|<=|>=|>|=|<
ID [A-Za-z][A-Za-z0-9]*


%%

{PROGRAM}   {return tPROGRAM;}

{BEGIN}     {return tBEGIN;}

{END}       {return tEND;}

{IF}        {return tIF;}

{THEN}      {return tTHEN;}

{ELSE}      {return tELSE;}

{RELOP}     {std::string val = std::string(yytext);
             if(val == "<>") yylval = Relop::NotEqual;
             if(val == "<=") yylval = Relop::LesserEqual;
             if(val == ">=") yylval = Relop::GreaterEqual;
             if(val == ">") yylval = Relop::Greater;
             if(val == "=") yylval = Relop::Equal;
             if(val == "<") yylval = Relop::Lesser;
             return tRELOP;}

{VAR}       {return tVAR;}


{INT}       {return tINT;}

{REAL}      {return tREAL;}

{ID}        {return tIDENTIFIER;}

":="        {return tASSIGN;}

[0-9]+      {return tNUMBER;}

{SPACE}     {/*DO NOTHING*/}

<<EOF>>             { return DONE; }

.                   {return *yytext;}

%%


