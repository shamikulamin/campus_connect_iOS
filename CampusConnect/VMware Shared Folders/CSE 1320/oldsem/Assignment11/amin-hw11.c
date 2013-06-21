/*  Shamikul Amin
	ID: 1000834824
	CSE-1320-003
	Due: Wednesday, May 1st, 2013 @ 10AM */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main(void)
{
    FILE* fp;															/*Variable Declaration and initialization*/
    char buffer[100];
    char* del = ","; 
    char* del2 = "|";														/*Uses comma sign as delimiter*/
    char *token=NULL;
    char **array;
    char *array2[50];
    char filename[13]="bscs-2012.csv";
    char fn[13]="completed.txt";
    int i,k =0;
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
       		array[i] = malloc((strlen(token) + 1));
			strcpy(array[i], token);
			i=i+1;
    		token = strtok( NULL, del );
    	}
    }
    fp=fopen(fn,"r");
    while( fgets(buffer, sizeof(buffer), fp) != NULL )
    {
    	array2[k]=buffer;
    	k=k+1;
    }
    
    printf("Eligible classes");
    printf("----------------");
    for (x=0;x<i;x++)													
    {
    	if(strstr(array[x],array2[x])!=NULL)
    		printf("%s \n",array[x-2]);
    }
    free(array);												
    fclose( fp );														
}
