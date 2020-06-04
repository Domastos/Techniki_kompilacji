all: comp

comp : parser.tab.o
	  g++ -o comp parser.tab.o

parser.tab.c:
	bison parser.y

parser.tab.o: parser.tab.c
		cc -c -ly parser.tab.c

clean :
	rm comp parser.tab.c parser.tab.o