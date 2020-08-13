#ifndef EMITTER_H
#define EMITTER_H

#include <iomanip>
#include <string>
#include "global.hpp"

extern int getRelationalOperatorToken(std::string text);
extern int getSignOperatorToken(std::string text);
extern int getMulopOperatorToken(std::string text);

class MakeASM {
private:
    std::stringstream stream;
public:
    void writeToStream(std::string str);
    void writeToStream(std::string str1, std::string str2);
    void writeToFile();
};

#endif