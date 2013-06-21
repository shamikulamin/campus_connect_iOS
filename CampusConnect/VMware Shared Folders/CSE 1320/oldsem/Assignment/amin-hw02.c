/*  Shamikul Amin
	ID: 1000834824
	CSE-1320-003
	Due: Wednesday, February 6th, 2013 @ 10AM */



#include <stdio.h>

int main(void)
{
	int loop, count, max;  /* Lines 12 to 16 variables declared and assigned */
	int index=0;
	float avg=0.0;
	char label1[]="column maximums";
	char label2[]="column averages";
	int table_set[4][10]={{1,  2,  3, -4,  5,  6,  -7,  8,  9, 10},{10,  9,  8, -7,  6,  5,  -4,  3,  2,  1}, /* 4x10 Data set used for program, can be changed to any numbers. */
						 {-5, -4, -3, -2, -1,  0,  -1,  2,  3,  4},{2,  3,  5, -7, 11, 13, -17, 19, 23, 31}};
					
	for (loop=0; loop<10; loop++) /* Loop responsible for printing all the values in the data set in a 4x10 table */
	{
		printf("%3d   ",table_set[index][loop]);
		if (loop==9)  /*Goes to next line when end of the first set is reached */
		{
			printf("\n");
			index++;
			loop=-1;   /*Resets so index doesn't go out of bounds */
			if (index==4)  /* Gets out of loop when every thing is printed */
				loop=10;
		}
	}
	
	for (count=0; count<60; count++) /* Responsible for the "=" division line separating the data from the results */
		printf("=");
	printf("\n");
	
	
	for (loop=0; loop<10; loop++) /* Loop responsible for finding the maximums for each column */
	{
		max=table_set[0][loop];  /*Resets max to the first value of the next column*/
		for(count = 0; count < 4; count++)  /*Checks for maximums*/
        	if(table_set[count][loop] > max)
            	max = table_set[count][loop];
        printf("%3d   ",max);;
    }

    printf("%17s",label1);
    printf("\n");
    for (loop=0; loop<10; loop++)  /* Loop responsible for finding the averages of each column */
	{
		for(count = 0; count < 4; count++)  /*Loop that adds all the values in the column*/
        	avg=avg + table_set[count][loop];
        avg=avg/4;
        printf("%6.02f",avg);
        avg=0;
    }
    printf("%17s\n",label2);
		
}
