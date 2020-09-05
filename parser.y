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
COMPILATION_UNIT: PROGRAM {

}
;

PROGRAM: tPROGRAM tIDENTIFIER '('IDENTIFIER_LIST')' ';'
		 { 
		  #if DEBUG == 1
			std::cout << "DEBUG: program identifier: " << $2 << std::endl;
			std::cout << std::string(40, '-') << std::endl;
		   #endif

			isGlobal = true;
			makeasm.writeToStream(("	jump.i	#" + symboltable.getSymbolAtIndex($2).getName()), ";\tSTART OF PROGRAM");
			makeasm.writeToStream((symboltable.getSymbolAtIndex($2).getName()+':'), ("\t\t\t;\texecuting " + symboltable.getSymbolAtIndex($2).getName()));
			symboltable.editSymbolAtIndex($2, LABEL, 0, 0);
        	argsSupportVector.clear();
		}
 	  DECLARATIONS
 	  SUBPROGRAM_DECLARATIONS 
	   {
	
	   }
 	  COMPOUND_STATEMENT
	   '.'
	   {
		   makeasm.writeToStream("\texit", "\t\t\t;\tEND OF PROGRAM");
		   makeasm.writeToFile();
	   }
;

IDENTIFIER_LIST: tIDENTIFIER 
		{	
			#if DEBUG == 1
			std::cout << "DEBUG: identifier num: " << $1 << std::endl;
			#endif

			checkIfVariableExists($1);
			argsSupportVector.push_back($1);
		}
	| IDENTIFIER_LIST ',' tIDENTIFIER
		{
			#if DEBUG == 1
			std::cout << "DEBUG: identifier list num: " << $3 << std::endl;
			#endif

			checkIfVariableExists($3);
			argsSupportVector.push_back($3);
		}
;

DECLARATIONS: DECLARATIONS tVAR IDENTIFIER_LIST ':' TYPE ';' 
		{	
			#if DEBUG == 1
			std::cout << "DEBUG: tVAR: " <<  $2 <<std::endl;
			#endif

			for(auto &index : argsSupportVector){

			#if DEBUG == 1
			std::cout << "DEBUG: index: " << index <<std::endl;
			#endif

				switch($5) {
                	case tINT:
						symboltable.editSymbolAtIndex(index, tVAR, tINT, VarSizes::integer_size);
						break;
					case tREAL:
						symboltable.editSymbolAtIndex(index, tVAR, tREAL, VarSizes::real_size);
						break;
					default:
						std::cerr << "ERROR: UNSUPPORTED TYPE" << std::endl;
						YYERROR;
				}
			
			}
		argsSupportVector.clear();
		}
	| %empty
;

TYPE: STANDARD_TYPE {$$ = $1;}
	| tARRAY '[' tNUMBER '.' '.' tNUMBER ']' tOF STANDARD_TYPE
	 {std::cerr << "UNSUPPORTED" << "\n";}
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
        | STATEMENTS';' STATEMENT
;

STATEMENT: VARIABLE tASSIGN EXPRESSION
		{	
			makeasm.genAssignment($1, $3);
		}
	|  PROCEDURE_STATEMENT
	|  COMPOUND_STATEMENT
	|  tIF EXPRESSION tTHEN STATEMENT tELSE STATEMENT
	|  tWHILE EXPRESSION tDO STATEMENT
;
VARIABLE: tIDENTIFIER
	{
		checkIfVariableExists($1);
		std::cout << "VAR is " << $1 << std::endl;
		$$ = $1;
	}
	| tIDENTIFIER '['EXPRESSION ']'
;

PROCEDURE_STATEMENT: tIDENTIFIER
	| tIDENTIFIER '(' EXPRESSION_LIST ')'
	{
		int write = symboltable.lookUp("write");
		int read = symboltable.lookUp("read");
		if($1 == write){
			for(auto &index : argsSupportVector){
				makeasm.writeToStream("\twrite", makeasm.genMnemonikType(index), std::to_string(symboltable.getSymbolAtIndex(index).getAddress()), makeasm.genAnotation("\twrite", makeasm.genMnemonikType(index), index));
			}
		}
		if($1 == read){
			for(auto &index : argsSupportVector){
				makeasm.writeToStream("\tread", makeasm.genMnemonikType(index), std::to_string(symboltable.getSymbolAtIndex(index).getAddress()), makeasm.genAnotation("\tread", makeasm.genMnemonikType(index), index));
			}
		}
	argsSupportVector.clear();
	}
;

EXPRESSION_LIST: EXPRESSION 
	{
		argsSupportVector.push_back($1);
	}
	| EXPRESSION_LIST ',' EXPRESSION
	{
		argsSupportVector.push_back($3);
	}
;

EXPRESSION: SIMPLE_EXPRESSION  {$$ = $1;}
	| SIMPLE_EXPRESSION tRELATIONAL_OPERATOR SIMPLE_EXPRESSION
;

SIMPLE_EXPRESSION: TERM
	| tSIGN TERM 
	{ 	
		switch($1){
			case Sign::Positive:
				$$ = $2;
				break;
			case Sign::Negative:
				$$ = symboltable.insertSymbol(Symbol("$", tVAR, tINT));
		}
	}
	| SIMPLE_EXPRESSION tSIGN TERM{

		$$ = makeasm.genExpression(tSIGN, $2, $1, $3);
	}
	| SIMPLE_EXPRESSION tOR TERM
;

TERM: FACTOR
	| TERM tMULOP FACTOR {
		$$ = makeasm.genExpression(tMULOP, $2, $1, $3);
	}
;

FACTOR: VARIABLE 
		{	
		#if DEBUG_FACTOR == 1
			std::cout<<"DEBUG_FACTOR: VARIABLE " << $1 << std::endl;
		#endif
			$$ = $1;
		}
	| tIDENTIFIER '(' EXPRESSION_LIST ')'
	{
	#if DEBUG_FACTOR == 1
		std::cout<<"DEBUG_FACTOR: IDENTIFIER FUNCTION/PROCEDURE " << $1 << std::endl;
		$$ = $1;
	#endif
	}
	| tNUMBER
	{
		#if DEBUG_FACTOR == 1
		std::cout<<"DEBUG_FACTOR: NUMBER " << $1 << std::endl;
	#endif
	}
	| '(' EXPRESSION ')' 
	{$$ = $2;}
	| tNOT FACTOR
	{}
;
%%

