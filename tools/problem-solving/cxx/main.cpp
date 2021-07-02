#include <stdio.h>

#define __max_buffer_s__ 255


const char* sum(const char* str1, const char* str2, bool recursive=false)
{
    static char buffer[__max_buffer_s__] = "";
    static int buffer_s = 0;

    if (recursive)
    {
        printf("buffer_s: %d\n", buffer_s);
        return &buffer[buffer_s];
    }

    char* loc = &buffer[buffer_s];
    while (buffer[buffer_s++] = *str1++);
    buffer_s--;
    while (buffer[buffer_s++] = *str2++);

    if (buffer_s > __max_buffer_s__)
    {
        printf("'buffer overflow' is detected.\n");
        throw (unsigned char)257;
    }
    const char* _ = sum("", "", true);

    return loc;
}


class Box
{
    int _val = 0;
public:
    Box()
    {
    }
    ~Box()
    {
        printf("%p ~Box()\n", &_val);
    }
    void mutate()
    {
        _val = 2;
    }
};


int main()
{
    unsigned char failed = 0;

    printf("TEST 1=========================================================\n");
    try
    {
        const char* str1 = sum("aaaa", "bbbbb");
        const char* str2 = sum("cc", "ddd");
        printf("%s\n", str1);
        printf("%s\n", str2);
        printf("%s\n", sum(sum(&str2[2], " - "), "*"));
    }
    catch (unsigned char err_code)
    {
        failed = err_code;
    }
    printf("\n");

    printf("TEST 2=========================================================\n");
    int size = 3;
    while (size--)
    {
        printf("countdown %d\n", size);
        Box box1;
        box1.mutate();
        Box box2 = box1;
    }
    printf("\n");

    return failed;
}
