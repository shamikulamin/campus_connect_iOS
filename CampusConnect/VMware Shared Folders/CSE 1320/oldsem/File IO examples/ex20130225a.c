/*
      date:  February 25, 2013
  category:  file I/O
   purpose:  display a file's contents
*/

#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    FILE* fp;
    char buffer[100];
    char filename[] = "data.csv";

    if( (fp = fopen(filename, "r")) == NULL )
    {
        printf("unable to open %s for reading\n", filename);
        exit( 1 );
    }

    while( fgets(buffer, sizeof(buffer), fp) != NULL)
    {
        printf("read ==> %s", buffer);
    }

    fclose(fp);
}
