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

SOURCES=parser.cpp lexer.cpp symtable.cpp
OBJMODELS=$(SOURCES:.cpp=.o)

parser.cpp: parser.y symtable.hpp
		bison $(BISONFLAGS) $(BISONOUTPUT)

lexer.cpp: lexer.l 
		flex --outfile=lexer.cpp lexer.l

%.o: %.cpp %.hpp
	$(CXX) $(CPPFLAGS) -c $< -o $@ 

comp: main.cpp $(OBJMODELS)
	$(CXX) $(CPPFLAGS) $^ -o $@


run: comp
		./comp "Tests/pascal/t0.pas" "Tests/output/t0"

cleanintermediate:
		rm -f *.o

clean: cleanintermediate
		rm -f parser.cpp parser.hpp lexer.cpp