/*
      date:  February 27, 2013
  category:  file I/O
   purpose:  write to a file
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
    FILE* fp;
    char* filename = "outfile.txt";
    int i;

    if( (fp = fopen(filename, "w")) == NULL )
    {
        printf("unable to open %s\n", filename);
        exit(1);
    }

    for(i = 10; i < 25; i++)
        fprintf(fp, "something %d\n", i);

    fclose( fp );
}
