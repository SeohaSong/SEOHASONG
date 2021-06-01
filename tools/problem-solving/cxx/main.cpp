#include <iostream>


using namespace std;


int main()
{
    int val = 10;

    auto run = [&]() {
        if (val == 1)
        {
            throw val;
        }
        cout << val << endl;
        val--;
    };

    try
    {
        while (true)
        {
            run();
        }
    }
    catch(int val)
    {
        return val;
    }

    return 0;
}
