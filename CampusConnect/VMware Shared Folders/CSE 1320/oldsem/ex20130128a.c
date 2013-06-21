/*
      date:  January 28, 2013
  category:  arrays
   purpose:  find max of array
*/

#include <stdio.h>

int main(void)
{
    int d[] = {3, -4, 17, 8};
    int max = d[0];
    int i;

    for(i = 0; i < 4; i++)
        if(d[i] > max)
            max = d[i];

    printf("the max is %d\n", max);
}
