/*  Shamikul Amin
	ID: 1000834824
	CSE-1320-003
	Due: Wednesday, February 13th, 2013 @ 10AM */


#include <stdio.h>
#include <string.h>


int counts(char string[]);						/* Function Declaration */
void longestWord(char s[], int count_test[]);

int main(void)
{
	int count_test[100];									/*Variable Initialization*/
	int a,b;
	char z[]="This is one of Several strings2use.";
	char x[]="This sample has less than 987654321 leTTers.";
	char y[]="Is thIs a string? (definitely)";



    a=counts(z);														/*Calls function to do the processes */
    b=longestWords(z,count_test);
    printf("string 1: words = %3d, longest = %3d characters\n",a+1,b);
    a=counts(x);
    b=longestWords(x,count_test);
    printf("string 2: words = %3d, longest = %3d characters\n",a+1,b);
    a=counts(y);
    b=longestWords(y,count_test);
    printf("string 3: words = %3d, longest = %3d characters\n",a+1,b);

}
    
int counts (char string[])				/*Function responsible for counting the # of words */
{
	int count_words=0,i;
	for(i=0; i<strlen(string); i++)
	{
		if(((string[i]>64)&&(string[i]<91))||((string[i]>96)&&(string[i]<123)))
		{
		}
		else
		{
			if (((string[i]<65)&&(string[i+1])<65)||((string[i]>122)&&(string[i+1])<122))
			{
			}
			else
				count_words++;
		}
 	}
	return count_words;
}


int longestWords(char string[], int count_test[])		/*Function to find the longest word length */
{
	int longword=0;
	int compare_word=0,i;
	for(i=0; i<strlen(string); i++)
	{
		if(((string[i]>64)&&(string[i]<91))||((string[i]>96)&&(string[i]<123)))
		{
			longword++;
		}
		else
		{
			if(longword>compare_word)
				{
					compare_word=longword;
					longword=0;
				}
				else
				{
				}
			longword=0;
		}
 	}
	return compare_word;
}


	
	
