#include <iostream>
#include <string>
#include <vector>
using namespace std;

%%{
    
    machine number_parser;
    
    whole_number = digit+
        >to{intVal=0;}
        ${intVal = intVal*10 + (fc-'0');}
    ;
    
    action foundNumberAction {
        cerr << "detected " << intVal << ",  p = " << p << endl;
        intVec.push_back(intVal);
    }
    
main :=
        space* 
        'bond' %{cerr << "saw 'bond'" << endl;}
        (space+  whole_number %foundNumberAction)+
        space* 0
        @{ print_info();}
    ;
    
#main := bond_line;
    
}%%

%% write data;

int intVal;
vector<int> intVec;

void print_info(void)
{
    for(int i=0; i<intVec.size(); ++i)
        cout << intVec[i] << "  ";
    cout << endl;
}


int main(void)
{
    char linebuf[512] = "";
    
    while(true) {
        cout << "Enter a string: ";
        cin.getline(linebuf, 511);
        linebuf[511] = '\0';
        if(string(linebuf) == "quit")
            break;
        
        cout << "Parsing: " << linebuf << endl;
        char *p = linebuf, *pe = p + strlen(linebuf), *eof = 0;
        int cs;
        // Confirm that the terminal '\0' is being sent to the machine
        cout << "(int)*pe = " << (int)*pe << '(' << *pe << ')' << endl;
        intVec.clear();
        
        %% write init;
        %% write exec;
        
        if(cs == number_parser_error) {
            cerr << "Error encountered" << endl;
            break;
        }
    }
    return 0;
}
