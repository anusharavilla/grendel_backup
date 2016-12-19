#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <bitset>
#include <cstdlib>
#include <cmath>
#include <algorithm>
#include<iomanip>
#include<string.h>
#include<istream>
#include<limits.h>
#include<cuda_runtime.h>
using namespace std;

// Matrices are stored in row-major order:
// M(row, col) = *(M.elements + row * M.width + col)
typedef struct {
 int width;
 int height;
 float* elements;
} Matrix;
// Thread block size
#define BLOCK_SIZE 64
// Forward declaration of the matrix multiplication kernel
__global__ void MatMulKernel(const Matrix, const Matrix, Matrix);
// Matrix multiplication - Host code
// Matrix dimensions are assumed to be multiples of BLOCK_SIZE

char mystring [9999999];
int main()
{

double** M1;
double** M2;

//char a[20];
char* p;
int i,j;
   FILE * pFile;
   
   int cols1=0;
   int rows1=0;
   int cols2,rows2=0;
   pFile = fopen ("input_large.txt" , "r");
     if ( fgets (mystring , 9999999 , pFile) != NULL )
       for(i=0;i<strlen(mystring);i++)
	   {
		   if(mystring[i]=='\t')
			   cols1++;
	   }
     fclose (pFile);
   //cout<<cols1<<endl;
   pFile = fopen ("input_large.txt" , "r");
   rows1=0;
   while(fgets(mystring,9999999,pFile)!=NULL)
   {
    if(mystring[0]=='\n')
	   break;
   rows1++;
   }
  // cout<<rows1<<endl;
  //  pFile = fopen ("input_large.txt" , "r");
   while(fgets(mystring,9999999,pFile)!=NULL)
   {
    cols2=0;    
	 for(i=0;i<strlen(mystring);i++)
	   {
		   if(mystring[i]=='\t')
			   cols2++;
	   }
	   rows2++;
   }	   
   
   //cout<<cols2<<endl<<rows2;
   cols1++;
   cols2++;

   fclose (pFile);
   
//cout<<"hi"<<endl;   
   cout<<cols1<<endl<<rows1<<endl<<cols2<<endl<<rows2<<endl;
   






M1= (double**) malloc(rows1*sizeof(double*));
//cout<<"hi"<<endl;
for(i=0;i<rows1;i++)
M1[i]=(double*) malloc(cols1*sizeof(double));
//cout<<"hello";

M2= (double**) malloc(rows2*sizeof(double*));
for(i=0;i<rows2;i++)
M2[i]=(double*) malloc(cols2*sizeof(double));
//cout<<"hello";

pFile = fopen ("input_large.txt" , "r");
i=0;
while(fgets(mystring,9999999,pFile)!=NULL)
{
	
	if(mystring[0]=='\n')
		goto abc;
	p=mystring;
	
		for(j=0;j<cols1;j++)
			M1[i][j]=strtod(p,&p);

	i++;
}

abc:
i=0;
while(fgets(mystring,9999999,pFile)!=NULL)
{
	p=mystring;
		
		for(j=0;j<cols2;j++)
			M2[i][j]=strtod(p,&p);

	i++;
}

fclose (pFile);

 // Load A and B to device memory

 Matrix A,B,C;
A.width=cols1;
B.width=cols2;
A.height=rows1;
B.height=rows2;
C.width=A.width+B.width-1;
C.height=A.height+B.height-1;
C.elements=(float*)malloc(C.height*C.width*sizeof(float));
//cout<<"hi";

A.elements=(float*)malloc(A.width*A.height*sizeof(float));
//for(i=0;i<(A.width*A.height);i++)
	//A.elements[i]=1;
	i=0;

	for(int g=0;g<rows1;g++)
{
for(int h=0;h<cols1;h++ )
{
A.elements[i]=M1[g][h];
i++;
}
}	

	B.elements=(float*)malloc(B.width*B.height*sizeof(float));
//for(i=0;i<(B.width*B.height);i++)
	//B.elements[i]=1;
	i=0;
for(int q=0;q<rows2;q++)
{
for(int w=0;w<cols2;w++ )
{
B.elements[i]=M2[q][w];
i++;
}
}
//for(i=0;i<(B.height*B.width);i++)
//cout<<B.elements[i]<<"\t";
//cout<<endl;
 Matrix d_A;
 d_A.width = A.width; d_A.height = A.height;
 size_t size = A.width * A.height * sizeof(float);
 cudaMalloc(&d_A.elements, size);
 cudaMemcpy(d_A.elements, A.elements, size,
 cudaMemcpyHostToDevice);
 Matrix d_B;
 d_B.width = B.width; d_B.height = B.height;
 size = B.width * B.height * sizeof(float);
 cudaMalloc(&d_B.elements, size);
 cudaMemcpy(d_B.elements, B.elements, size,
 cudaMemcpyHostToDevice);
 // Allocate C in device memory
 Matrix d_C;
 d_C.width = C.width; d_C.height = C.height;
 size = C.width * C.height * sizeof(float);
 cudaMalloc(&d_C.elements, size);
 // Invoke kernel
dim3 threadsPerBlock(BLOCK_SIZE,BLOCK_SIZE); 
    
	dim3 numBlocks((C.width+BLOCK_SIZE-1)/BLOCK_SIZE,(C.height+BLOCK_SIZE-1)/BLOCK_SIZE);
	//dim3 numBlocks((int)ceil((float)(C.width)/BLOCK_SIZE),(int)ceil((float)(C.height)/BLOCK_SIZE));
 MatMulKernel<<<numBlocks, threadsPerBlock>>>(d_A, d_B, d_C);
 // Read C from device memory
 cudaMemcpy(C.elements, d_C.elements, size,
 cudaMemcpyDeviceToHost);
 // Free device memory
 cudaFree(d_A.elements);
 cudaFree(d_B.elements);
 cudaFree(d_C.elements);

 for(i=0;i<(C.width*C.height);i++)
 {
 //if(.elements[i]!=0)
 cout<<C.elements[i]<<" ";
//else break;
 }
 cout<<endl<<i;
 
 }
// Matrix multiplication kernel called by MatMul()
__global__ void MatMulKernel(Matrix A, Matrix B, Matrix C)
{
 // Each thread computes one element of C
 // by accumulating results into Cvalue
 
 int row = blockIdx.y * blockDim.y + threadIdx.y;
 int col = blockIdx.x * blockDim.x + threadIdx.x;
   
   if(row<C.height && col<C.width)
   {
 for (int e = 0; e < B.height; ++e)
 for (int c=0;c<B.width;++c)
 {
 if((row>=e)&& (col>=c) && (A.height>(row-e)) && (A.width>(col-c)))
 C.elements[row * C.width + col] += A.elements[(row-e) * A.width + col-c]
 * B.elements[e * B.width + c];
 }
 
 }
 
 
 }