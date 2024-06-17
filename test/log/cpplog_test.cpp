#include <dummy/dummy.h>
#include <utils/log.h>
#include <mathnipet.h>

#include <iostream>
using namespace std;

int main(void)
{
    print_msg("Hello, world!");
    LOG(LOG_LVL::DBUG, GRN("Hello"), YLW(","), RED("world!"));
    LOG(LOG_LVL::INFO);
    LOG(LOG_LVL::WARN, "1 + 1", "=", add(1, 1));
    LOG(LOG_LVL::ERRO, "1 - 1", "=", sub(1, 1));
    LOG(LOG_LVL::FATL, "log test complete...");

    #if defined(BUILD_TYPE_DEBUG)
    LOG(LOG_LVL::DBUG, GRN("debug mode"));
    #endif

    cout << "press Enter to continue..." << endl;
    if (getchar()) {}
    return 0;
}

