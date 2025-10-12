#include <stdio.h>

extern int printf_s(char *fmt, ...);

int main(int argc, char const *argv[])
{
    //char s[] = "RRR";
    //printf_s("ggg%sfff\n", s);
    char c = 'R';
    printf_s("%c", 'R');
    //int d = 78966;
    //printf_s("ggg%dfff\n", d);
    return 0;
}
