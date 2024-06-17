#include <iostream>
using namespace std;

#include "add.h"
#include "dummy.h"
#include "dummy2.h"


int main(int argc, char** argv)
{
    Add addt(1, 2);
    cout << addt.Calc() << endl;
    print_msg("this is dummy");
    print_msg2("this is dummy2");
    cout << dumyi << endl;
    #if defined(CXX_COMPILER_ID_MSVC)
    cout << "cxx compiler is msvc..." << endl;
    #endif
    cout << "press Enter to continue..." << endl;
    if (getchar()) {}
    
    return 0;
}
