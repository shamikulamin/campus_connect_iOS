/*  Shamikul Amin
	ID: 1000834824
	CSE-1320-001
	Due: June 12, 2013 @ 10AM */



#include <stdio.h>
#include <stdlib.h>


int main(void)
{
	int i,k,m,l;
	int add=0;
	for(i=1;i<11;i++)
	{
    	printf("%2d: ",i); 
    	for(k=1;k<=i;k++) 
    	{
        	if(i%k==0)
        	{
            	m=i/k; 
            	add=add+m;
            	printf("%2d ",k); 
        	}
        	else
            	printf("   "); 
    	}
    	for(l=(10-i);l>0;l--)
        	printf("   ");
    	printf("| %2d\n",add); 
    	add=0;
   	}
}
