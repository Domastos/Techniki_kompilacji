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

%define parse.error verbose

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


%start STATEMENT
%left '>'
%left '+'
%left '-'


%%


STATEMENT: tIDENTIFIER tASSIGN EXPRESSION
	| tIF EXPRESSION tTHEN STATEMENT
	| tIF EXPRESSION tTHEN STATEMENT tELSE STATEMENT
	| tBEGIN STATEMENTS tEND
;

STATEMENTS:    STATEMENT ';'
        | STATEMENT ';' STATEMENTS

;

EXPRESSION:    tNUMBER
        | tIDENTIFIER
        | EXPRESSION '+' EXPRESSION
        | EXPRESSION '-' EXPRESSION
        | EXPRESSION '>' EXPRESSION
;

%%
