/*
date:      April 15, 2012
category:  data structures
purpose:   use adjacency matrix to represent graph
*/

#define SIZE 8
#include <stdio.h>

void printGraph(int d[][SIZE], char label[]);
void dfs(int row, int d[][SIZE], char label[], int visited[]);
void init(int v[]);

int main(void)
{
    char label[] =    {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'};
   /*  undirected graph  */
    int und[][SIZE] = {{0,   1,   1,   1,   0,   0,   0,   0 },   /* A */
                       {1,   0,   0,   1,   0,   0,   0,   0 },   /* B */
                       {1,   0,   0,   0,   1,   0,   0,   0 },   /* C */
                       {1,   1,   0,   0,   1,   0,   0,   0 },   /* D */
                       {0,   0,   1,   1,   0,   0,   0,   0 },   /* E */
                       {0,   0,   0,   0,   0,   0,   1,   1 },   /* F */
                       {0,   0,   0,   0,   0,   1,   0,   1 },   /* G */
                       {0,   0,   0,   0,   0,   1,   1,   0 } }; /* H */
    /*  directed graph  */
    int dir[][SIZE] = {{0,   1,   1,   1,   0,   0,   0,   0 },   /* A */
                       {0,   0,   0,   1,   0,   0,   0,   0 },   /* B */
                       {0,   0,   0,   0,   1,   0,   0,   0 },   /* C */
                       {0,   1,   0,   0,   1,   0,   0,   0 },   /* D */
                       {0,   0,   0,   1,   0,   0,   0,   0 },   /* E */
                       {0,   0,   0,   0,   0,   0,   1,   0 },   /* F */
                       {0,   0,   0,   0,   0,   0,   0,   1 },   /* G */
                       {0,   0,   0,   0,   0,   1,   0,   0 } }; /* H */
    int visited[SIZE];  /* 0 means unvisited */
    
    printf("undirected\n");
    printGraph(und, label);
    printf("\n\n");
    printf("directed\n");
    printGraph(dir, label);

    init(visited);  /* reset */
    printf("\n\n");
    printf("depth-first traversal\n");
    dfs(0, und, label, visited);
    
    init(visited);  /* reset */
    printf("\n\n");
    printf("depth-first traversal--directed\n");
    dfs(0, dir, label, visited);
    printf("\n");
}

void init(int v[])
{
    int i;
    for(i = 0; i < SIZE; i++)
        v[i] = 0;     /* 0 means unvisited */
}

void dfs(int row, int d[][SIZE], char label[], int visited[])
/*
    print row label (i.e., current node)
    for each connected node
    find first connected and unvisited node
        dfs(current unvisited node)

    for each unvisited row (jump to unconnected graphs)
        dfs(current unvisited row)
*/
{
    int k;

    printf("%c ", label[row]);
    visited[row] = 1;

    for(k = 0; k < SIZE; k++)
        if(d[row][k] != 0 && visited[k] == 0)
            dfs(k, d, label, visited);

    /* handle sections disconnected from previously visited parts */
    for(k = 0; k < SIZE; k++)
        if(visited[k] == 0)
            dfs(k, d, label, visited);
}

void printGraph(int d[][SIZE], char label[])
/*
    for each row
        print row label
        for each column
            if arc connected
                print column label
*/
{
    int i, k;

    for(i = 0; i < SIZE; i++)
    {
        printf("%c:  ", label[i]);
        for(k = 0; k < SIZE; k++)
            if(d[i][k] != 0)
                printf("%c ", label[k]);

        printf("\n");
    }
}
