#include <iostream>
#include <iomanip>
#include <fstream>
#include <sstream>
#include <cstdlib>
#include <string.h>
#include <stdio.h>
#include <cmath>
#include <bitset>
#include <stdlib.h>
using namespace std;

int main()
{   
     
    std::vector< std::vector<double> > table; 
    std::fstream ifs;

    /*  open file  */
    ifs.open(input.txt);

    while (1)
    {
        std::string line;
        double buf;
        getline(ifs, line);

        std::stringstream ss(line, std::ios_base::out|std::ios_base::in|std::ios_base::binary);

        if (!ifs)
            // mainly catch EOF
            break;

        if (line[0] == '#' || line.empty())
            // catch empty lines or comment lines
            continue;


        std::vector<double> row;

        while (ss >> buf)
            row.push_back(buf);


        table.push_back(row);


    }

    ifs.close();
	
	cout<<table[1][0];

}