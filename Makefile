all: comp

comp : parser.tab.o lex.yy.o
	  g++ -o comp  parser.tab.o lex.yy.o

parser.tab.o: parser.tab.c
		cc -c -ly parser.tab.c

lex.yy.o : lex.yy.c
		cc -c lex.yy.c

lex.yy.c: lexer.lex
		flex lexer.lex

parser.tab.c:
	bison -d parser.y

clean :
	rm comp parser.tab.c parser.tab.h parser.tab.o lex.yy.c lex.yy.o
