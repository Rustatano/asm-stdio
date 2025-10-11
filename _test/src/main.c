#include <stdio.h>

extern int printf_s(char *fmt, ...);

int main(int argc, char const *argv[])
{
    printf_s("ggg%cfff\n", 'R');
    return 0;
}
