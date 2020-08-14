%{
    #define YYDEBUG 1
	
	#include <iostream>
    #include <string>
    #include <sstream>
    #include "symtable.hpp"
	#include "emitter.hpp"
	#include "error.hpp"
    int yylex(void);
    int yyparse(void);
	bool isGlobal = true;
	
    inline void yyerror (char const *s) {
        std::cerr << s << std::endl;
    }

	std::vector<int> argsSupportVector;
    MakeASM makeasm;
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
%token tARRAY
%token tOF
%token tFUNCTION
%token tPROCEDURE
%token tWHILE
%token tDO
%token tOR
%token tNOT
%token tSIGN
%token tMULOP
%token tRELATIONAL_OPERATOR
%token DONE 0


%start COMPILATION_UNIT


%%
COMPILATION_UNIT: PROGRAM {}
;

PROGRAM: tPROGRAM tIDENTIFIER '('IDENTIFIER_LIST')' ';'
 	  DECLARATIONS
 	  SUBPROGRAM_DECLARATIONS 
	   {
			makeasm.writeToStream("lab0:");
	   }
 	  COMPOUND_STATEMENT
	   '.'
	   {
		   makeasm.writeToStream("exit");
		   makeasm.writeToFile();
	   }
;

IDENTIFIER_LIST: tIDENTIFIER 
		{
			checkIfVariableExists($1);
			argsSupportVector.push_back($1);
		}
	| tIDENTIFIER ',' IDENTIFIER_LIST 
		{
			checkIfVariableExists($3);
			argsSupportVector.push_back($1);
		}
;

DECLARATIONS: DECLARATIONS tVAR IDENTIFIER_LIST ':' TYPE ';' 
		{
			for(auto &index : argsSupportVector){
				if($5 == tINT || $5 == tREAL){
					symboltable.editSymbolAtIndex(index, tVAR, $5, 4);
				} else{
					std::cerr << "ERROR: UNSUPPORTED TYPE" << std::endl;
					YYERROR;
				}
			}
			argsSupportVector.clear();
		}
	| %empty
;

TYPE: STANDARD_TYPE|
	tARRAY '[' tNUMBER '.' '.' tNUMBER ']' tOF STANDARD_TYPE {std::cerr << "UNSUPPORTED" << "\n";}
;

STANDARD_TYPE: 	tINT {$$ = tINT;}
	| tREAL {$$ = tREAL;}
;

SUBPROGRAM_DECLARATIONS: SUBPROGRAM_DECLARATIONS SUBPROGRAM_DECLARATION ';'
	| %empty
;

SUBPROGRAM_DECLARATION: SUBPROGRAM_HEAD DECLARATIONS COMPOUND_STATEMENT
;

SUBPROGRAM_HEAD: tFUNCTION tIDENTIFIER ARGUMENTS ':' STANDARD_TYPE ';'
	| tPROCEDURE tIDENTIFIER ARGUMENTS ';'
;

ARGUMENTS: '('PARAMETR_LIST')'
	| %empty
;

PARAMETR_LIST: IDENTIFIER_LIST ':' TYPE
	| PARAMETR_LIST ';' IDENTIFIER_LIST ':' TYPE
;

COMPOUND_STATEMENT: tBEGIN OPTIONAL_STATEMENTS tEND
;

OPTIONAL_STATEMENTS: STATEMENTS
	| %empty
;

STATEMENTS:    STATEMENT
        | STATEMENT ';' STATEMENTS
;

STATEMENT: VARIABLE tASSIGN EXPRESSION
	|  PROCEDURE_STATEMENT
	|  COMPOUND_STATEMENT
	|  tIF EXPRESSION tTHEN STATEMENT tELSE STATEMENT
	|  tWHILE EXPRESSION tDO STATEMENT
;
VARIABLE: tIDENTIFIER
	| tIDENTIFIER '['EXPRESSION ']'
;

PROCEDURE_STATEMENT: tIDENTIFIER
	| tIDENTIFIER '(' EXPRESSION_LIST ')'
;

EXPRESSION_LIST: EXPRESSION
	| EXPRESSION_LIST ',' EXPRESSION
;

EXPRESSION: SIMPLE_EXPRESSION
	| SIMPLE_EXPRESSION tRELATIONAL_OPERATOR SIMPLE_EXPRESSION
;

SIMPLE_EXPRESSION: TERM
	| tSIGN TERM
	| SIMPLE_EXPRESSION tSIGN TERM
	| SIMPLE_EXPRESSION tOR TERM
;

TERM: FACTOR
	| TERM tMULOP FACTOR
;

FACTOR: VARIABLE
	| tIDENTIFIER '(' EXPRESSION_LIST ')'
	| tNUMBER
	| '(' EXPRESSION ')' {$$ = $2;}
	| tNOT FACTOR
;
%%

