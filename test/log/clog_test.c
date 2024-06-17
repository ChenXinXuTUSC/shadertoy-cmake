#include <clog.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
    LOG(DBUG, "hello, world");
    #if defined(DEBUG)
    LOG(DBUG, "debug mode");
    #endif

    printf("press Enter to continue...\n");
    if (getchar()) {}

    return 0;
}
