CXX = g++ 
CXXFLAGS = -std=c++17


all: comp

comp : main.o lexer.o parser.o symtable.o
	  	g++ -std=c++17 -o comp  main.o lexer.o parser.o symtable.o

main.o: main.cpp parser.hpp
		g++ -std=c++17 main.cpp -c -o main.o

symtable.o: symtable.cpp symtable.hpp
		g++ -std=c++17 symtable.cpp -c -o symtable.o

lexer.o: lexer.cpp symtable.hpp
		g++ -std=c++17 lexer.cpp -c -o lexer.o

lexer.cpp: lexer.l parser.hpp symtable.hpp
		flex --outfile=lexer.cpp lexer.l

parser.o: parser.cpp parser.hpp
		g++ -std=c++17 parser.cpp -c -o parser.o

parser.cpp parser.hpp: parser.y symtable.hpp
		bison --output=parser.cpp --defines=parser.hpp parser.y

clean: cleanintermediate
		rm -f parser.cpp parser.hpp lexer.cpp comp

cleanintermediate:
		rm -f *.o
