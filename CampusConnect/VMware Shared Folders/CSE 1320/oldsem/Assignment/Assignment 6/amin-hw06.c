#include <stdio.h>
#include <stdlib.h>
#include <string.h>


struct person {
  		char* name;
    	char* item;
    	int quant;
    	int cost;
    	};



int main(void)
{
    FILE* fp;																/*Variable Declaration and initialization*/
    char buffer[100];
    char* del2= " ."; 														/*Uses dollar sign as delimiter*/
    char* token;
    char filename[13]="hw06-data.txt";
    char tempString[30];
    char tempString2[30];
    char* acName;
    int value;
    int pos=0;
    int t;

    													
	struct person listing[20];
	
    	if( (fp = fopen(filename, "r")) == NULL )
    	{
        	printf("unable to open %s\n", filename);
        	exit(1);
    	}
    	while( fgets(buffer, sizeof(buffer), fp) != NULL )
    	{
        	token = strtok(buffer, del2);
        	listing[pos].name=token;
        	while(token!=NULL)
        	{
        		sprintf(tempString2,"%s",token);
        		if(isdigit(tempString2[0])==1)
        		{
        			value=atoi(token);
        			listing[pos].quant=value;
        		}
        		if(strcmp(tempString2, "books")==0 ||strcmp(tempString2, "shirts")==0 ||strcmp(tempString2, "meals")==0 ||strcmp(tempString2, "coats")==0)
        		{	
					listing[pos].item=token;
        		}
        		if(*("$")==tempString2[0])
        		{
        			acName=tempString2;
        			acName++;
        			value=atoi(acName);
        			listing[pos].cost=value;
        		}
        		token=strtok(NULL,del2);
        	}
        	pos++;
    	}
    	printf("%s\n",listing[0].item);
    	fclose(fp);													/*Closes the current file*/
}


