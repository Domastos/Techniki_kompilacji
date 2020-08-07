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

SOURCES=main.cpp symtable.cpp lexer.cpp parser.cpp
HEADERS=gloval.hpp symtable.hpp parser.hpp 
OBJMODELS=parser.o lexer.o  symtable.o

parser.cpp: parser.y symtable.hpp
		bison $(BISONFLAGS) $(BISONOUTPUT)

lexer.cpp: lexer.l 
		flex --outfile=lexer.cpp lexer.l

%.o: %.cpp %.hpp
	$(CXX) $(CPPFLAGS) -c $< -o $@ 

comp: main.cpp $(OBJMODELS)
	$(CXX) $(CPPFLAGS) $^ -o $@


run: comp
		./comp

cleanintermediate:
		rm -f *.o

clean: cleanintermediate
		rm -f parser.cpp lexer.cpp