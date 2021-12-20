#include <iostream>
#include <float.h>

using namespace std;

void printBit(float v)
{
    unsigned int* v0 = (unsigned int*)&v;
    for (int i = 0; i < 32; i++)
    {
        printf("%u", *v0 << i >> 31);
        if (i == 0 || i == 8 || i == 31)
        {
            printf(" ");
        }
    }
    printf("%.50f\n", v);
}

int main()
{
    float v = FLT_EPSILON;
    int ct = 0;
    while (true)
    {
        ct++;
        if (v / 2 == 0)
        {
            break;
        }
        v /= 2;
    }
    printf("%d\n", ct);
    printBit(v);
    printBit(FLT_MIN);
    printBit(FLT_EPSILON);
    printBit(1 - FLT_EPSILON);
    printBit(1 + FLT_EPSILON);
    printBit(1 + FLT_EPSILON * 2);
    printBit(0);
    printBit(1);
    printBit(2);
    printBit(4);
    for (int i = 0; i < 23; i++)
    {
        printf(" ");
    }
    printf("\n");
    return 0;
}
