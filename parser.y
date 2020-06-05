%{
    #include <iostream>
    #include <string>
    #include <sstream>
    int yylex(void);
    int yyparse(void);
    inline void yyerror (char const *s) {
        std::cerr << s << std::endl;
    }
%}

%token NONE
%token tBEGIN
%token tEND
%token tIF
%token tTHEN
%token tELSE
%token tASSIGN
%token tIDENTIFIER
%token tNUMBER
%token DONE 0


%start PROGRAM
%left '>'
%left '+'
%left '-'

%%
PROGRAM: STATEMENTS DONE
;

STATEMENTS:    STATEMENT
        | STATEMENT ';' STATEMENTS
;

STATEMENT: tIDENTIFIER tASSIGN EXPRESSION
	| tIF EXPRESSION tTHEN STATEMENT
	| tIF EXPRESSION tTHEN STATEMENT tELSE STATEMENT
	| tBEGIN STATEMENTS tEND
;

EXPRESSION:    tNUMBER
        | tIDENTIFIER
        | EXPRESSION '+' EXPRESSION
        | EXPRESSION '-' EXPRESSION
        | EXPRESSION '>' EXPRESSION
;

%%

