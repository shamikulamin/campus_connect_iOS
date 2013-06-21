/*  Shamikul Amin
	ID: 1000834824
	CSE-1320-001
	Due: June 19, 2013 @ 10AM */



#include <stdio.h>
#include <stdlib.h>


int main(void)
{
	int size,x,pos;
	char msg[] = "wklv lv zkb fvh uxohv";
	char decoded[sizeof(msg)/sizeof(msg[0])];
	
	
	size=sizeof(msg)/sizeof(msg[0]);
	for(x=0;x<size;x++)
	{
		pos=msg[x];
		if(pos>99 && pos<123)
			decoded[x]=msg[x]-3;
		else if (pos>96 && pos<100){
			decoded[x]=msg[x]+23;
		}
		else
			decoded[x]=msg[x];
	printf("%c",decoded[x]);
	}
	
}
