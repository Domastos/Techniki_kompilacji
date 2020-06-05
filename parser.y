%{
    #include <stdio.h>

    #define YYPRINT(file, type, value) fprintf(file, "%d", value);
%}

%token tBEGIN
%token tEND
%token tIF
%token tTHEN
%token tELSE
%token tASSIGN
%token tIDENTIFIER
%token tNUMBER


%start statement
%left '>'
%left '+'
%left '-'
%%

STATEMENT: tIDENTIFIER tASSIGN EXPRESSION
	| tIF EXPRESSION tTHEN STATEMENT
	| tIF EXPRESSION tTHEN STATEMENT tELSE STATEMENT
	| tBEGIN STATEMENTS tEND

STATEMENTS:    STATEMENT
        | STATEMENT ';' STATEMENTS
;

EXPRESSION:    tNUMBER
        | tIDENTIFIER
        | EXPRESSION '+' EXPRESSION
        | EXPRESSION '-' EXPRESSION
        | EXPRESSION '>' EXPRESSION

;

%%

int main (void)
{
  yyparse();
  return 0;
}

int error(char *s)
{
fprintf (stderr, "%s\n", s);
return 0;
}

# include "lex.yy.c"