%option noyywrap
%option noinput
%option nounput

%{
    #include "parser.hpp"
    int tokenval;
%}

ID [A-Za-z][A-Za-z0-9]*

%%

"begin"     {return tBEGIN;}

"end"       {return tEND;}

"if"        {return tIF;}

"then"      {return tTHEN;}

":="        {return tASSIGN;}

{ID}        {return tIDENTIFIER;}

[0-9]+      {return tNUMBER;}

[\t\r\n]

<<EOF>>             { return DONE; }

.                   {
                        tokenval = NONE;
                        return yytext[0];
                    }

%%


