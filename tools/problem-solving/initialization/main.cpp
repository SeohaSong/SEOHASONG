#include <iostream>

#define SIZE 100

using namespace std;

void run()
{
    // int vs[SIZE] = {};
    int* vs = new int[SIZE]();
    for (int i = 0; i < SIZE; i++)
    {
        if (vs[i])
        {
            printf("not null");
            break;
        }
    }
    delete[] vs;
}

int main()
{
    run();
    return 0;
}
