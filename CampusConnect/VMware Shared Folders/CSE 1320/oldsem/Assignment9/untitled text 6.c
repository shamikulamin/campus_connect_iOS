void bsort(person listed[], int size)
{
	struct person temp1;
	int i, j = 0;
	int s;
	for(i=1;i<size;i++)
	{
		for (j=0;j<size-i;j++)
		{
			s=strcmp(listed[j].name,listed[j+1].name);
			if (s>0)
			{
				temp1=listed[j];
				listed[j]=listed[j+1];
				listed[j+1]=temp1;
			}
		}
	}
}


void bsort(person listed[], int size);