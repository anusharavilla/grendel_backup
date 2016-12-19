#include <iostream>
#include <fstream>
#include <string>
using namespace std;

int main()
{
  string line1[30];
  string line2[30];
  ifstream myfile("input.txt");
  int a = 0;
  int b = 0;
  while(!myfile.eof())
  {
    getline(myfile,line1[a],'\n');
    cout<<"1."<<line1[a]<<"\n";
    getline(myfile,line2[b],'\n');
    cout<<"2."<<line2[b]<<"\n";
	 a++; b++;
  }
}


 /*
   //added lines
          if(temp_map.find(*it)->second->name == *it)   //(temp_map[itnew->second->name] == *it)
       {  
          count = count + temp_map[*it]->count;                //itnew->second->count;
          found = 1; 
        } 
 // else add up the number of leaf nodes 
        if(found == 0 )
        count++;
       else 
         found = 0;
  //added till here 
*/
