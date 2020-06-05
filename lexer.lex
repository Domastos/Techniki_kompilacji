%{
    #include "parser.tab.h"
%}

%option yylineno
%option noyywrap

ID [A-Za-z][A-Za-z0-9]*

%%

"begin"     {return tBEGIN;}
"end"   {return tEND;}
"if"    {return tIF;}
"then"  {return tTHEN;}
":="    {tASSIGN;}
{ID}    {return tIDENTIFIER;}
[0-9]+  {return tNUMBER;}
[\t\r\n] ; //whitespace
. {return *yytext;}

%%
