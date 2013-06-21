/*  Shamikul Amin
	ID: 1000834824
	CSE-1320-001
	Due: June 19, 2013 @ 10AM */



#include <stdio.h>
#include <stdlib.h>


int main(void)
{
	int x, y=0, i=3;
	int z,c,count;
	int primes[100];
	
	printf("2\n");
	
	for ( count = 2 ; count <= 101 ;  )
   	{
      for ( c = 2 ; c <= i - 1 ; c++ )
      {
         if ( i%c == 0 )
            printf("-1\n");
      }
      if ( c == i )
      {
         printf("%d\n",i);
         count++;
      }
      i++;
   }
}
