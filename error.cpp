#include "error.hpp"

void checkIfVariableExists(int id)
{
    if(id == -1){
        std::cerr << "Indefined variable" << std::endl;
    }
}