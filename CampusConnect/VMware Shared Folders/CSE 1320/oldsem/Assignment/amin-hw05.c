/*  Shamikul Amin
	ID: 1000834824
	CSE-1320-003
	Due: Wednesday, March 6th, 2013 @ 10AM */
	

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void meanvar(int d[30],double sum,int elements, double* mean, double* var);  /*Function Declaration*/

int main(void)
{
    FILE* fp;																/*Variable Declaration and initialization*/
    char buffer[100];
    char* del = "$"; 														/*Uses dollar sign as delimiter*/
    char* token;
    int value,i,k;
    int max, min,count=0;
    double add, var,mean;
    int data[30];
    char filename[11];
    
    for (k=0;k<100;k++)														/*Loop to process all 100 files*/
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
        	if(strcmp(token, "$") == 1)
        	{
            	token = strtok(NULL, del);
            	value = atoi(token);
            	add=add+value;
            	data[count]=value;
            	if (count==0)												/*First values do not need comparison*/
            	{
            		min=value;
            		max=value;
            		count++;
            	}
            	else														/*Compares all other values with the previous values*/
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
    	meanvar(data,add,count,&mean,&var);									/*Calls the function to calculate the mean and variance*/
    	printf("hw05-data-%02d.txt: min = %3d, max = %3d, mean =  %.2f, variance =  %7.2f\n",k,min,max,mean,var);
    	count=0;															/*Resets all variables to process the next file*/
    	min=0;
    	max=0;
    	var=0;
    	mean=0;
    	add=0;
    	fclose( fp );														/*Closes the current file*/
    }
}

void meanvar(int d[30],double sum,int elements, double* mean, double* var)  /*Mean and sample variance function*/
{
	int i;
	*mean=0.0;
	*var=0.0;	
	*mean=sum/elements;														
	for (i=0;i<elements;i++)
    	*var += (d[i] - *mean)*(d[i] - *mean);
    *var=*var/(elements-1);
	
}	

