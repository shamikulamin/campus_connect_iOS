/*
      date:  February 27, 2013
  category:  file I/O
   purpose:  using stdin
*/

#include <stdio.h>

int main(void)
{
    char buffer[100];

    while( fgets(buffer, sizeof(buffer), stdin) != NULL )
        printf("read ==> %s", buffer);
}
