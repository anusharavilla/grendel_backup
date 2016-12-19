#include <iostream>
#include <fstream>
#include <string>
#include <conio.h>
using namespace std;

int main()
{
string a;
ifstream myfile("input.txt".c_str());
myfile.open();
getline(myfile,a,'\n');
myfile.close();
int b = a.size();
cout<<"The size is\t"<<b<<"\n";
}