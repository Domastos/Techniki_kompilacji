all: comp

comp : lex.yy.o
	  g++ -o comp lex.yy.o

lex.yy.с :
		flex lexer.l

lex.yy.o : lex.yy.c
		cc -c lex.yy.c

clean :
	rm comp lex.yy.o lex.yy.c