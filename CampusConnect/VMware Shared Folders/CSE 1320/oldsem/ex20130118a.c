/*
      date:  January 18, 2013
  category:  conditionals
   purpose:  demonstrate how things can go wrong
*/

#include <stdio.h>

int main(void)
{
    int a = 10;

    if(a = 5)
        printf("does a = 5?\n");

    if(100 < 3 < 2)
        printf("why is this true?\n");
}
