#include "log.h"
#include <string>


std::string color_str(std::string str, LOG_COLOR fore_code, LOG_COLOR back_code)
{
    std::string fore_code_str = "";
    if (fore_code != LOG_COLOR::FORE_ORG)
        fore_code_str = ";" + std::to_string(int(fore_code));
    std::string back_code_str = "";
    if (back_code != LOG_COLOR::BACK_ORG)
        back_code_str = ";" + std::to_string(int(back_code));
    std::string ret = concate_strs("\033[1", fore_code_str, back_code_str, "m", str, "\033[0m");
    return ret;
}
