#include <iostream>
#include <fstream>
#include <string> /*#include <conio>*/
#include <stdlib.h>
#include <sstream>
using namespace std;
int main()
{ //double size = GetSize("input.txt"); cout<<"\t"<<"size:"<<size<<"\n";
int onereach = 0;int j=0, k=0, cnt1=0;
int rows2=0; int rows1=0;int column1=0, column2=0;
string line1; string a;double word; double *array1, *array2 , **array_1, **array_2; 

ifstream file( "input.txt", ios::binary | ios::ate);
int size = file.tellg();  cout<<"\t"<<"size:"<<size<<"\n";

size=size/2; ///////////can have size also 
array1 = new double[size];
array2=new double[size];
ifstream myfile("input.txt");
if (myfile.is_open())
    {
     while ( getline (myfile,line1) )
     {                  cout<<"\n";            
                        if(line1.length()==1) onereach=1;
                       if(onereach==0){ rows1++;   
                          istringstream iss(line1);                         
                         while( iss >> word )     
                          {   cout<<word<<"\t";
                              column1++;                           
                              array1[j] = word;
                               j++;
                            } 
                         }
      if(onereach==1){    if(line1.length()==0) break;
                         rows2++; 
                         istringstream iss(line1);                      
                         while( iss >> word )     
                          {    cout<<word<<"\t";
                               array2[k]=word;
                               column2++; 
                              k++;} 
                           }           
      }
      rows2=rows2-1;
      column1=column1/rows1;
      column2=column2/rows2;
      cout << "row, column " <<rows1<<"\t"<<column1<<"\n"<<rows2<<"\t"<<column2<<"\t"<<"\n";;
      myfile.close();
   }


for(int l=0;l<size; l++)
   cout<<"\t"<<array1[l]; cout<<"\n";
for(int m=0;m<size; m++)
   cout<<"\t"<<array2[m];

    array_1 = (double **)malloc(sizeof(double *) * rows1);
    for (j = 0 ;  j < rows1; j++) 
    array_1[j] = (double *)malloc(sizeof(double ) * column1);
  
    array_2= (double **)malloc(sizeof(double *) * rows2);
    for (j = 0 ;  j < rows2; j++) 
    array_2[j] = (double *)malloc(sizeof(double ) * column2);



for(j=0;j<rows1;j++)
{for(k=0;k<column1;k++)
{ array_1[j][k] = array1[cnt1];
   cnt1++; }
}
cnt1=0;
for(j=0;j<rows2;j++)
{for(k=0;k<column2;k++)
{ array_2[j][k] = array1[cnt1];
   cnt1++; }
}
cout<<"\n";
for(j=0;j<rows1;j++)
{for(k=0;k<column1;k++)
{ cout<<array_1[j][k]<<"\t"; } cout<<"\n";
}
cout<<"\n";
for(j=0;j<rows2;j++)
{for(k=0;k<column2;k++)
{ cout<<array_2[j][k]<<"\t"; } cout<<"\n";
}

}
