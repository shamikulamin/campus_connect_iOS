#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hw08-header.h"


struct node {
		char queu[50];
    	struct node *next;
    	};
    	
    	
int main(int argc, char* argv[])
{
    int i = 0;
    char *value = "go";
    int key, count=0;
    char* del = ","; 														/*Uses comma sign as delimiter*/
    char *token=NULL;
    
    struct node *head=NULL, *previous=NULL, *temp;

    if(argc != 2)
    {
        printf("  usage:  program_name positive_integer\n");
        printf("example:  ./example-hw08  123\n");
        exit(1);
    }

    /**************  begin REQUIRED  **************/
    /*  put before logic.  DO NOT PUT IN A LOOP */
    key = atoi(argv[1]);
    initialize(key);
    /**************   end REQUIRED   **************/

    /*  example loop  */
    while(strcmp(value, "stop") != 0)
    {
        value = getString();
        token = strtok(value, del);
        while (token !=NULL)
        {
        	temp = malloc( sizeof(struct node) );
        	printf(token);
        	strcpy(temp->queu,token);
        	temp->next=head;
			head=temp;
			token = strtok( NULL, del );
		}
 	
    }
    
	while(head != NULL)
    {
        printf("%s\n", head->queu);
        head = head->next;
    }
  
    
    
    
}


