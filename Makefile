all: comp

comp : main.o lexer.o parser.o
	  	g++ -o comp  main.o lexer.o parser.o

main.o: main.cpp parser.hpp
		g++ main.cpp -c -o main.o

lexer.o: lexer.cpp
		g++ lexer.cpp -c -o lexer.o

lexer.cpp: lexer.lex parser.hpp
		flex --outfile=lexer.cpp lexer.lex

parser.o: parser.cpp parser.hpp
	g++ parser.cpp -c -o parser.o

parser.cpp parser.hpp: parser.y
		bison --output=parser.cpp --defines=parser.hpp parser.y

clean: cleanintermediate
		rm -f parser.cpp parser.hpp lexer.cpp comp

cleanintermediate:
		rm -f *.o
