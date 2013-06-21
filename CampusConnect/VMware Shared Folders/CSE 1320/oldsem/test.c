#include<stdlib.h>
#include<stdio.h>


struct node{
	int value;
	struct node *next;
	}


int main(void) {

	int num=50;
	int i;
	struct node* first = NULL; /* NULL is used to know where
	the list ends */
	struct node* temp;
  	for(i = 0; i < num; i++)
	{
		temp = (struct node*) malloc(num * sizeof(struct node) );
		temp->value = i;
		temp->next = first;
		first = temp;
		printf("%d\n", first->value);
	}
}
