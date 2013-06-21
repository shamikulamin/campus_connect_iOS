/*
      date:  February 27, 2013
  category:  file I/O
   purpose:  look for lines with specific tokens
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
    FILE* fp;
    char buffer[100];
    char* del = "$";
    char* token;
    int value,i,k;
    int max, min,count=0;
    double mean=0.0,varsum;
    int data[30];
    char filename[11];
    
    for (k=0;k<100;k++)
    {
    	 sprintf(filename,"hw05-data-%02d.txt",k);

    	if( (fp = fopen(filename, "r")) == NULL )
    	{
        	printf("unable to open %s\n", filename);
        	exit(1);
    	}

    	while( fgets(buffer, sizeof(buffer), fp) != NULL )
    	{
        	token = strtok(buffer, del);
        	if(strcmp(token, " $") == 1)
        	{
            	token = strtok(NULL, del);
            	value = atoi(token);
            	mean=mean+value;
            	data[count]=value;
            	if (count==0)
            	{
            		min=value;
            		max=value;
            		count++;
            	}
            	else
            	{
            		if (value>max)
            			max=value;
            		else if (value<min)
            			min=value;
            		count++;
            	}
        	}
        	else
        		printf("problem\n");
    	}
    	mean=mean/count;
    	for (i=0;i<count;i++)
    	{
    		varsum += (data[i] - mean)*(data[i] - mean);
    	}
    	varsum=varsum/(count-1);
    	printf("hw05-data-%02d.txt: min = %3d, max = %3d, mean =  %.2f, variance =  %7.2f\n",k,min,max,mean,varsum);
    	count=0;
    	min=0;
    	max=0;
    	varsum=0;
    	mean=0;

    	fclose( fp );
    }
}

