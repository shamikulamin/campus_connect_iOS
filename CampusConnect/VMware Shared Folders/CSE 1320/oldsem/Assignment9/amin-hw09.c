/*  Shamikul Amin
	ID: 1000834824
	CSE-1320-003
	Due: Wednesday, April 17th, 2013 @ 10AM */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hw09-header.h"


struct student {
  		char* name;
    	char* course;
    	};
    	
void sort(student array, int count);  /*Function Declaration*/
    	
int main(int argc, char* argv[])
{
    int i = 0, init_size=10,x,z;
    char *value = "go";
    int key, count=0;
    char* del = ","; 														/*Uses comma sign as delimiter*/
    char *token=NULL;
    char *temp_stor;
    struct student *array;
    struct student *temp;
    

    if(argc != 2)
    {
        printf("  usage:  program_name positive_integer\n");
        printf("example:  ./example-hw09  123\n");
        exit(1);
    }

    /**************  begin REQUIRED  **************/
    /*  put before logic.  DO NOT PUT IN A LOOP */
    key = atoi(argv[1]);
    initialize(key);
    /**************   end REQUIRED   **************/

    /*  example loop  */
    
    array=malloc((init_size)*sizeof(int));
    
    while(strcmp(value, "stop") != 0)
    {
        value = getString();
        token = strtok(value, del);
        while (strcmp(value, "stop") != 0)
        {
        	if(i%4==0)
        	{
        		printf("limit reached, increasing array structure by 4\n");
        		init_size=init_size*2;
        		temp = realloc(array,init_size*sizeof(int)) ;
				if(temp != NULL)
				{
					array = temp;
				}
				else
				{
					printf("unable to reallocate\n");
					exit(1);
				}
			}
			
			
        	array[i].name=malloc(sizeof(struct student)*10);
        	strcpy(array[i].name,token);
			token=strtok(NULL,del);
			array[i].course=malloc(sizeof(struct student)*11);
			strcpy(array[i].course,token);
			printf("%s wishes to enroll in %s\n",array[i].name,array[i].course);
			i=i+1;
			value = getString();
        	token = strtok(value, del);
			for(x=0;x<i;x++)
			{
				if(strcmp(array[x].name,token)==0)
				{
					token=strtok(NULL,del);
					value = getString();
        			token = strtok(value, del);
					if(strcmp(array[x].course,token)==0)
						printf("***%s is already enrolled in %s***\n",array[x].name,array[x].course);
				}
			}
		}
		sort(array,i);
		for(x=0;x<i;x++)
    	{
    		printf("%-10s %-9s\n",array[x].name,array[x].course);
    	}
    }
    
     
}

void sort(student array, int count)						
{
	int k,j;
	struct student *temp;
	for(k=1; k < count-1 ; k++)
	{
        for(j=k+5; j< count; j=j++)
        {
            if(strcmp(arrays[k].name,arrays[j].name) > 0)
            {
                strcpy(temp,arrays[k]);
                strcpy(arrays[k],arrays[j]);
                strcpy(arrays[j],temp);
            }
        }
    }
}



