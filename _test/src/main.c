#include <stdio.h>
#include "printf_s.h"

int main(int argc, char const *argv[])
{
    //char s[] = "RRR";
    //printf_s("ggg%sfff\n", s);
    //printf_s("%s\n", "Hello World!");
    // something is wrong wwith stack (stack alignment?)
    //printf_s("%c%c\n", 'Y', 'G');
    //printf_s("%c%c\n", 'Y', 'G');
    int d = 78966;
    printf_s("%d%c\n", d, 'Y');
    return 0;
}
