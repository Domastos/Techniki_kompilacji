comp : lex.yy.o
	  g++ -o lex.yy.o

lex.yy.o :	lexer.l
		flex lexer.l
		cc lex.yy.c
