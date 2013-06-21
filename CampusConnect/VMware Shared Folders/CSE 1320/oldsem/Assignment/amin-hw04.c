/*  Shamikul Amin
	ID: 1000834824
	CSE-1320-003
	Due: Monday, February 25th, 2013 @ 10AM */


#include <stdio.h>	/*Library Imports*/
#include <string.h>
#include <math.h>


void fx1(int d[][5], int rows, int* colIndex, int* maxSum);					/*Function Declaration*/
void fx2(int d[][5], int rows, int colIndex, double* mean, double* var);


int main(void)
{
	int maxSum;			/*Variable Declaration*/
	int colIndex;
	int n,p;
	double mean,var;
	int table_set1[][5]={{55, 8, 12, 6, -1},{-10, 4, 7, 5, -6},{-20, 0, 15, 4, -2}};   /*Data Initialization */
	int table_set2[][5]={{1, 6, -2, 5, 14},{0, 4, 3, -5, 12},{2, 4, 5, -6, 12},{4, 7, 15, 4, 16},{3, 9, 4, 0, 17}};
	
	n=sizeof(table_set1) / sizeof(table_set1[0]); /*Finds the number of rows on the set of data */
	p=sizeof(table_set2) / sizeof(table_set2[0]);

	fx1(table_set1,n,&colIndex,&maxSum);  /*Calls upon a sum function */
	printf("For the first array, the column with index %d has the maximum sum of %d\n",colIndex,maxSum);
	
	fx2(table_set1,n,colIndex,&mean,&var);  /*Calls upon the mean and sample variance function*/
	printf("It has a mean of %6.3f and a variance of %6.3f\n\n",mean,var);
	
	fx1(table_set2,p,&colIndex,&maxSum);
	printf("For the second array, the column with index %d has the maximum sum of %d\n",colIndex,maxSum);
	
	fx2(table_set2,p,colIndex,&mean,&var);
	printf("It has a mean of %6.3f and a variance of %5.3f\n",mean,var);
	
}

void fx2(int d[][5], int rows, int colIndex, double* mean, double* var)   /*Mean and sample variance function*/
{
	int i, j;
	*mean=0;
	*var=0;
	for (i=0;i<rows;i++)
	{
		*mean=*mean+d[i][colIndex];	
	}
	*mean=*mean/rows;
	for (j=0;j<rows;j++)
	{
		*var=*var+(pow((d[j][colIndex]-*mean),2.0)/(rows-1));
	}
	
}	

void fx1(int d[][5], int rows, int* colIndex, int* maxSum)  /*Sum Function*/
{
	int i, j,max=0,index=0;
	*maxSum=0;
	*colIndex=0;
	for (j=0;j<5;j++)
	{
		for (i=0;i<rows;i++)
		{
				max=max+d[i][j];

		}
		index++;
		if (max>*maxSum)
		{
			*maxSum=max;
			max=0;
			*colIndex=index-1;
		}
		else
		{
			max=0;
		}
	}
}	
	
