%{
    #include <iostream>
    #include <string>
    #include <sstream>
    #include "symtable.hpp"
    int yylex(void);
    int yyparse(void);
    inline void yyerror (char const *s) {
        std::cerr << s << std::endl;
    }

%}

%define parse.error verbose


%token NONE
%token tPROGRAM
%token tBEGIN
%token tEND
%token tIF
%token tTHEN
%token tELSE
%token tVAR
%token tINT
%token tREAL
%token tASSIGN
%token tIDENTIFIER
%token tNUMBER
%token tRELATIONAL_OPERATOR
%token DONE 0


%start COMPILATION_UNIT
%left '>'
%left '+'
%left '-'


%%
COMPILATION_UNIT: PROGRAM
;

PROGRAM: tPROGRAM tIDENTIFIER PROGRAM_PARAM ';' BLOCK '.'
;

PROGRAM_PARAM: '('IDENTIFIERS')'
;

IDENTIFIERS: tIDENTIFIER
	| tIDENTIFIER ',' IDENTIFIERS
;

BLOCK:   DECLARATIONS STATEMENT
;

DECLARATIONS: tVAR VARIABLE_DECLARATION ';'
	| tVAR VARIABLE_DECLARATION ';' DECLARATIONS
	| %empty
;

VARIABLE_DECLARATION: IDENTIFIERS ':' TYPE
;

TYPE: 	tINT
	| tREAL
;

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

