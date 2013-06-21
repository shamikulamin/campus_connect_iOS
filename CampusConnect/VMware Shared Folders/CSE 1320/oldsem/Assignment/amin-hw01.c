/*  Shamikul Amin
	ID: 1000834824
	CSE-1320-003
	Due: January 30th, 2012 @ 10AM */



#include <stdio.h>
#include <stdlib.h>


int main(void)
{
	double rand_num1; /*Lines 7 to 10 are variables set aside for the random numbers generated */
	double rand_num2;
	double rand_num3;
	double rand_num4;
	double limit_const=RAND_MAX/99.99; /*Constant that helps keep the random numbers within the 0.0-99.99 range */
	int loop1; /*Variable set aside for the loop*/
	double avg_sum; /*Variable that keeps track of all the numbers above 67.0 as one big some to make finding the average simpler */
	int avg_counter=0; /* Variable that keeps track of what to divide by to find the average */
	
	for(loop1=1; loop1<5; loop1++) /*Loop for each line on the table */
	{
		avg_sum=0.0; /*Sets or resets the sum to 0*/
		avg_counter=0;  /*Resets counter to 0*/
		rand_num1=(rand()/limit_const);  /*Lines 20 to 23 generate the random numbers */
		rand_num2=(rand()/limit_const);
		rand_num3=(rand()/limit_const);
		rand_num4=(rand()/limit_const);
			
		if (rand_num1>=67.0) /*Checks to see if the random number is larger than or equal to 67 */
		{
			avg_sum=avg_sum+rand_num1; /*Adds the random number to the sum */
			avg_counter=avg_counter+1; /*Increments the counter*/
			printf("%.02f  ",rand_num1); /*Prints and spaces out the number */
		}
		else
			printf("       "); /*Prints empty space if number is below 67.0 */
			
		if (rand_num2>=67.0)
		{
			avg_sum=avg_sum+rand_num2;
			avg_counter=avg_counter+1;
			printf("%.02f  ",rand_num2);
		}
		else
			printf("       ");
				
		if (rand_num3>=67.0)
		{
			avg_sum=avg_sum+rand_num3;
			avg_counter=avg_counter+1;
			printf("%.02f  ",rand_num3);
		}
		else
			printf("       ");
				
		if (rand_num4>=67.0)
		{
			avg_sum=avg_sum+rand_num4;
			avg_counter=avg_counter+1;
			printf("%.02f  |  ",rand_num4);
		}
		else
			printf("       |  ");
		
		if (avg_counter>0) /*Checks to see if the counter is greater than 0 to avoid division by 0 */
		{	
			avg_sum=avg_sum/avg_counter; /* Calculates the average */
			printf("%.02f\n",avg_sum); /*Prints out the average */
		}
		else
			printf("\n");
				
	}	
	
}
