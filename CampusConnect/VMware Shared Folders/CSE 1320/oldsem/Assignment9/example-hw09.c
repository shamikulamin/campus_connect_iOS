/*
    Sun Apr  7 18:02:46 CDT 2013
    CSE 1320, hw #9

    example file for demonstrating how to use functions required for this assignment

    to use this file, do the following:
    1)  download the following to your directory on omega:
      a) example-hw09.c  (this file)
      b) hw09-header.h
      c) hw09-source.o
    2) compile this file and link to the object file using
        gcc -std=c89 -pedantic example-hw09.c hw09-source.o
*/

#include <stdio.h>
#include <stdlib.h>
#include "hw09-header.h"    /*  note header  */


/* REQUIRED:  you must write the code to receive command-line parameters */
int main(int argc, char* argv[])
{
    int i = 0;
    char *value = "go";
    int key;

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
    while(strcmp(value, "stop") != 0)
    {
        value = getString();
        printf("%2d:  %s\n", ++i, value);
    }
}

