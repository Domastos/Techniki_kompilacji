CXX = g++

DEBUG ?= 0
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

SOURCES = parser.cpp lexer.cpp symtable.cpp emitter.cpp error.cpp
OBJMODELS=$(SOURCES:.cpp=.o)
HEADERS=$(SOURCES:.cpp=.hpp)

comp: main.cpp $(OBJMODELS)
		$(CXX) $(CPPFLAGS) $^ -o $@

parser.cpp: parser.y
		bison $(BISONFLAGS) $(BISONOUTPUT)

lexer.cpp lexer.hpp: lexer.l 
		flex --outfile=lexer.cpp lexer.l

%.o: %.cpp %.hpp
		$(CXX) $(CPPFLAGS) -c $< -o $@ 

.PHONY: run_arithtest run_iftest run_whiletest valgrind cleanintermediate clean

run_arithtest: comp
		./comp "Tests/pascal/arithtest.pas" "Tests/output/arithtest" > logs.txt

run_iftest: comp
		./comp "Tests/pascal/t0.pas" "Tests/output/t0" > logs.txt

run_whiletest: comp
		./comp "Tests/pascal/t1.pas" "Tests/output/t1" > logs.txt

valgrind: comp
		valgrind -s --leak-check=full --show-leak-kinds=all ./comp "Tests/pascal/arithtest.pas" "Tests/output/arithtest"
		echo "################################################"
		valgrind -s --leak-check=full --show-leak-kinds=all ./comp "Tests/pascal/t0.pas" "Tests/output/t0"
		echo "################################################"
		valgrind -s --leak-check=full --show-leak-kinds=all ./comp "Tests/pascal/t1.pas" "Tests/output/t1"

cleanintermediate:
		rm -f *.o

clean: cleanintermediate
		rm -f parser.cpp parser.hpp lexer.cpp



main.cpp: global.hpp
parser.cpp: emitter.hpp symtable.hpp error.hpp
symtable.cpp: global.hpp symtable.hpp
emitter.cpp: global.hpp parser.hpp
error.cpp: global.hpp

