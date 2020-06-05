all: comp

comp : lex.yy.o
	  g++ -o comp lex.yy.o

lex.yy.o : lex.yy.c
		cc -c lex.yy.c


lex.yy.c: lexer.l
		flex lexer.l
clean :
	rm comp lex.yy.o lex.yy.c