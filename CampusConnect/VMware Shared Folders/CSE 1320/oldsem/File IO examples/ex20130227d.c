/*
      date:  February 27, 2013
  category:  file I/O
   purpose:  using argc and argv
*/

#include <stdio.h>

int main(int argc, char* argv[])
{
    int i;

    printf("argc = %d\n\n", argc);

    for(i = 0; i < argc; i++)
        printf("argv[%d] = %s\n", i, argv[i]);
}
