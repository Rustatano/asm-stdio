#include <stdio.h>
#include "printf_s.h"

int main(int argc, char const *argv[])
{
    char s[] = "RRR";
    //printf_s("f%ssdf\ngdf\n", s);
    //printf_s("%s\n", "Hello World!");
    // something is wrong wwith stack (stack alignment?)
    //printf_s("%c%c\n", 'Y', 'G');
    //printf_s("%c%c\n", 'Y', 'G');
    int d = 78966;
    //printf_s("%d", d);
    //printf_s("%d", d);
    //printf_s("f%d-%c\n", d, 'Y');
    //printf_s("f%d-%c\n", d, 'Y');
    printf_s("f%ssdf\ngdf-%dRR\n", s, d);

    return 0;
}
