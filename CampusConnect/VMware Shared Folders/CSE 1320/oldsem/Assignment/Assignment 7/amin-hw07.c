/*  Shamikul Amin
	ID: 1000834824
	CSE-1320-003
	Due: Wednesday, April 1st, 2013 @ 10AM */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void sort(char* inputArray[], int count, int inc);  /*Function Declaration*/

int main(void)
{
    FILE* fp;																/*Variable Declaration and initialization*/
    char buffer[100];
    char* del = ","; 														/*Uses comma sign as delimiter*/
    char *token=NULL;
    char **array;
    char filename[13]="hw07-data.csv";
    int i =0;
    int x, y=1, z=0;
    
    array=malloc((sizeof(*array)*500));
    
    if( (fp = fopen(filename, "r")) == NULL )
    	{
        	printf("unable to open %s\n", filename);
        	exit(1);
    	}

    while( fgets(buffer, sizeof(buffer), fp) != NULL )
    {
    	token = strtok(buffer, del);
		while (token !=NULL)
		{
			if (token[(strlen(token)-1)]== *("\n"))			/* Removes newline character */ 
				token[(strlen(token)-1)] = '\0';
       		array[i] = malloc((strlen(token) + 1));
			strcpy(array[i], token);
			i=i+1;
    		token = strtok( NULL, del );
    	}
    }
    for (x=0;x<i;x++)										/*Prints names originally*/
    {
    	printf("%-9s ",array[x]);
    	if(y%5==0)
    		printf("\n");
    	y=y+1;
    }
    
    printf("\n");
    
    sort(array,i,z);		/*sorts first column*/
    sort(array,i,z+1);		/*sorts second column*/
    sort(array,i,z+2);		/*sorts third column*/
    sort(array,i,z+3);		/*sorts fourth column*/
    sort(array,i,z+4);		/*sorts fifth column*/

    
    for (x=0;x<i;x++)													/*Prints sorted names*/
    {
    	printf("%-9s ",array[x]);
    	if(y%5==0)
    		printf("\n");
    	y=y+1;
    }
    free(array);														/*Frees Array*/
    fclose( fp );														/*Closes the current file*/
}

void sort(char* inputArray[], int count, int inc)						/*Sorting function*/
{
	int k,j;
	char temp[9];
	for(k=inc; k < count-1 ; k=k+5)
	{
        for(j=k+5; j< count; j=j+5)
        {
            if(strcmp(inputArray[k],inputArray[j]) > 0)
            {
                strcpy(temp,inputArray[k]);
                strcpy(inputArray[k],inputArray[j]);
                strcpy(inputArray[j],temp);
            }
        }
    }
}
