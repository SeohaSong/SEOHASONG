#include "mult.hpp"

using namespace std;

float run(int int_param, float float_param) {
    float ret = int_param * float_param; 
    cout << "cpp:\t " << ret << endl;
    return ret;
}
