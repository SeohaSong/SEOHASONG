(
    g++ -O3 -Wall -Werror -shared -std=c++14 -fPIC mult.cpp -o libmult.so
    python main_ctypes.py
)
