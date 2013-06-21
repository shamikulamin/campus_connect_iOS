/*
      date:  January 25, 2013
  category:  loops
   purpose:  for vs while
*/

#include <stdio.h>

int main(void)
{
    int i;

    for(i = 1; i < 5; i++)
    {
        if(i == 2)
            continue;

        printf("%d\n", i);
    }

    /* creates infinite loop */
    i = 1;
    while(i < 5)
    {
        if(i == 2)
            continue;

        printf("%d\n", i);
        i++;
    }
}
