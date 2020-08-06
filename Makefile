DEBUG ?= 0
CXX = g++

ifeq ($(DEBUG), 0)
	CPPFLAGS=-Wall -Wextra -O2
	LDFLAGS=
	BISONFLAGS=
else
	CPPFLAGS=-Wall -Wextra -O0 -g -ggdb
	LDFLAGS=
	BISONFLAGS=
endif

BISONOUTPUT=--output=parser.cpp --defines=parser.hpp parser.y

SOURCES=main.cpp symtable.cpp parser.cpp lexer.cpp
HEADERS=symtable.hpp parser.hpp
OBJMODELS=lexer.o parser.o symtable.o

lexer.cpp: lexer.l 
		flex --outfile=lexer.cpp lexer.l

parser.cpp: parser.y symtable.hpp
		bison $(BISONFLAGS) $(BISONOUTPUT)

%.o: %.cpp %.hpp
	$(CXX) $(CPPFLAGS) -c $< -o $@ 

comp: main.cpp $(OBJMODELS)
	$(CXX) $(CPPFLAGS) $^ -o $@

run: comp
		./comp

clean: cleanintermediate
		rm -f parser.cpp lexer.cpp

cleanintermediate:
		rm -f *.o
