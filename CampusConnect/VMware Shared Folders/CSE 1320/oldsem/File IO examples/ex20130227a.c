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
    char* filename = "hw05-data-00.txt";
    int value;

    if( (fp = fopen(filename, "r")) == NULL )
    {
        printf("unable to open %s\n", filename);
        exit(1);
    }

    while( fgets(buffer, sizeof(buffer), fp) != NULL )
    {
		token = strtok(buffer, del);
		printf("%d",token);
        if(strcmp(token, "$") == 0)
        {
        	printf("1");
            token = strtok(NULL, del);
            value = atoi(token);
            printf("%d\n",value);
        }
    }

    fclose( fp );
}
