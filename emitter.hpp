#ifndef EMITTER_H
#define EMITTER_H

#include <string>
#include "global.hpp"

extern int getRelationalOperatorToken(std::string text);
extern int getSignOperatorToken(std::string text);
extern int getMulopOperatorToken(std::string text);

#endif