//////// take out the slash t 
//////// take out kks kernel
//// change everything to double
#include <stdio.h>
#include <cuda_runtime.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <string> 
#include <sstream>
#include <sys/time.h>
using namespace std;
// Matrices are stored in row-major order:
// M(row, col) = *(M.elements + row * M.width + col)
typedef struct {
  int width;
 int height;
   double* elements;
} Matrix;

// Thread block size
#define BLOCK_SIZE 16
// Forward declaration of the matrix multiplication kernel
__global__ void MatMulKernel(const Matrix, const Matrix, Matrix);
// Matrix multiplication - Host code
// Matrix dimensions are assumed to be multiples of BLOCK_SIZE

int main(int argc,char *argv[])
{
// Error code to check return values for CUDA calls
    cudaError_t err = cudaSuccess;   
int onereach = 0;int j=0, k=0; 
int rows2=0; int rows1=0;int column1=0, column2=0;
string line1; string a;double word; double *array1, *array2 ; 
ifstream file( argv[1], ios::binary | ios::ate);
ulong size = file.tellg();  //cout<<"\t"<<"size:"<<size<<"\n";
size=size/2; ///////////can have size also 
array1 = new double[size];
array2=  new double[size];

ifstream myfile(argv[1]);
if (myfile.is_open())
    {
     while ( getline (myfile,line1) )
     {                             
                       if(line1.length()==1 || line1=="" ) onereach=1;
					  //if(line1=="") onereach=1;
                       if(onereach==0){ rows1++;   
                          istringstream iss(line1);                         
                         while( iss >> word )     
                          {   
                              column1++;                           
                              array1[j] = word;
                               j++;
                            } 
                         }
      if(onereach==1){    if(line1.length()==0 && rows2!=0) break;
                         rows2++; 
                         istringstream iss(line1);                      
                         while( iss >> word )     
                          {    
                               array2[k]=word;
                               column2++; 
                              k++;} 
                           }           
      }
      rows2=rows2-1;
      column1=column1/rows1;
      column2=column2/rows2;
      //cout << "row, column " <<rows1<<"\t"<<column1<<"\n"<<rows2<<"\t"<<column2<<"\n";;
      myfile.close();
   }
	Matrix h_A,h_B,h_C;	
	  h_A.width=column1; h_A.height=rows1;
	  h_B.width=column2; h_B.height=rows2;
	  h_C.width=(h_A.width+h_B.width-1);
	  h_C.height=(h_A.height+h_B.height-1);
        int numElements_A=h_A.width*h_A.height;
		int numElements_B=h_B.width*h_B.height;
        int numElements_C=h_C.width*h_C.height;
		 //	  size_t size = numElements * sizeof(float);
    //printf("[Matrix convolution of %d elements]\n", numElements_A);

    // Allocate the host input vector A
    h_A.elements = (double *)malloc(numElements_A * sizeof(double));

    // Allocate the host input vector B
    h_B.elements = (double *)malloc(numElements_B * sizeof(double));

    // Allocate the host output vector C
    h_C.elements= (double *)malloc(numElements_C * sizeof(double));

	// Verify that allocations succeeded
    if (h_A.elements == NULL || h_B.elements == NULL || h_C.elements == NULL)
    {
        fprintf(stderr, "Failed to allocate host vectors!\n");
        exit(EXIT_FAILURE);
    }	
    // Initialize the host input vectors
    for (int i = 0; i < numElements_A; ++i)
    { h_A.elements[i] = array1[i];
           }
for (int i = 0; i < numElements_B; ++i)
    {  h_B.elements[i] = array2[i];
	      }
///// gets allocated correctly 
	Matrix d_A;
 d_A.width = h_A.width; d_A.height = h_A.height;
 size_t size_A = h_A.width * h_A.height * sizeof(double);
 err = cudaMalloc(&d_A.elements, size_A);
  if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to allocate device vector A (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }
 err = cudaMemcpy(d_A.elements, h_A.elements, size_A,cudaMemcpyHostToDevice);
 if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy vector A from host to device (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }
 Matrix d_B;
 d_B.width = h_B.width; d_B.height = h_B.height;
 size_t size_B = h_B.width * h_B.height * sizeof(double);
 err = cudaMalloc(&d_B.elements, size_B);
 if (err != cudaSuccess)
    {  fprintf(stderr, "Failed to allocate device vector B (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);}
		
 err = cudaMemcpy(d_B.elements, h_B.elements, size_B, cudaMemcpyHostToDevice);
 if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy vector B from host to device (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }
 // Allocate C in device memory
 Matrix d_C;
 d_C.width = h_C.width; d_C.height = h_C.height;
 size_t size_C = h_C.width * h_C.height * sizeof(double);
 err=cudaMalloc(&d_C.elements, size_C); 
    if (err != cudaSuccess)
    {   fprintf(stderr, "Failed to allocate device vector C (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);  } 
 // Invoke kernel // check this ......
 dim3 dimBlock(BLOCK_SIZE, BLOCK_SIZE);
struct timeval begin, end; 
  gettimeofday (&begin, NULL); 
 dim3 dimGrid ((int)ceil((double)(h_C.height)/BLOCK_SIZE),(int)ceil((double)(h_C.width)/BLOCK_SIZE));
gettimeofday (&end, NULL); 
  int time_in_us = 1e6 * (end.tv_sec - begin.tv_sec) + (end.tv_usec - begin.tv_usec);
 MatMulKernel<<<dimGrid, dimBlock>>>(d_A, d_B, d_C);
   err = cudaGetLastError();

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to launch vectorAdd kernel (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }
 // Read C from device memory
err = cudaMemcpy(h_C.elements, d_C.elements, size_C, cudaMemcpyDeviceToHost);
    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy vector C from device to host (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }
for(int i =0;i<h_C.height; i++)
{ for(int z =0;z<h_C.width; z++)
cout<<h_C.elements[i*h_C.width + z]<<"\t"; cout<<"\n";}
 
 // Free device memory
 err = cudaFree(d_A.elements); 
    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to free device vector A (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }
err = cudaFree(d_B.elements);
    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to free device vector B (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }
 err = cudaFree(d_C.elements); 
         if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to free device vector C (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }	 

cout<<"\nthe time is:"<<time_in_us<<"\n";
return 0;
}
// Matrix multiplication kernel called by MatMul()
__global__ void MatMulKernel(Matrix A, Matrix B, Matrix C)
{
 double Cvalue = 0;
     int row = blockIdx.y * blockDim.y + threadIdx.y;
 int col = blockIdx.x * blockDim.x + threadIdx.x;
         		    __shared__ Matrix Sh;
			Sh = B; 
          if(col<C.width && row<C.height){ 
			 __syncthreads();
            for (int r = 0; r < Sh.height; r++) {
                for (int k = 0; k < Sh.width; k++){ 
                   if((row>=r)&&(col>=k)&&(A.height-(row-r)>0)&&(A.width-(col-k)>0))
                    Cvalue += Sh.elements[r* Sh.width + k] * A.elements[(row-r)*A.width + (col-k)];
                }
			C.elements[row * C.width + col] = Cvalue;}	}
 __syncthreads();

		 }


