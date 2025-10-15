#include <stdio.h>
#include "printf_s.h"

int main(int argc, char const *argv[])
{
    //char s[] = "RRR";
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
       
    // vvvvvvv segfault - fix it vvvvvv
    //printf_s("%cello, Wor%s %d %r%%%%%[%d] %s %c", 'H', "ld!", 2025, -125, "Hi again", '\n');
    //printf_s("f %c sdf\ngdf- %c %tfsdfsd%%%%gg%%h\n", 'Q', 'A');
    //printf_s("f %c sdf\ngdf- %c %tfsdfsd%%%%gg%%h\n", 'Q', 'A');
    //printf_s("%s", "Hello");
    //printf_s("%c", 'G');
    printf_s("A%d\n", -145);
    printf_s("B");
    //printf_s("%d", 154);

    return 0;
}
