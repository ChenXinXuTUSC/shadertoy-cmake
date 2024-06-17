#ifndef LOG_H
#define LOG_H
#include <iostream>
#include <sstream>
#include <string>
#include <chrono>
#include <iomanip>

template<typename... Args>
std::string concate_strs(Args... strs);
template<typename... Args>
std::string concate_strs(Args... strs)
{
    std::string concate = "";
    ((concate += std::string(strs)), ...); // only C++17 support fold expanding expression
    return concate;
}


enum class LOG_COLOR
{
    FORE_ORG = 0,
    FORE_BLK = 30,
    FORE_RED = 31,
    FORE_GRN = 32,
    FORE_YLW = 33,
    FORE_BLE = 34,
    FORE_PRP = 35,
    FORE_CYN = 36,
    FORE_WHE = 37,

    BACK_ORG = 0,
    BACK_BLK = 40,
    BACK_RED = 41,
    BACK_GRN = 42,
    BACK_YLW = 43,
    BACK_BLE = 44,
    BACK_PRP = 45,
    BACK_CYN = 46,
    BACK_WHE = 47,
};

std::string color_str(std::string str, LOG_COLOR fore_code, LOG_COLOR back_code);
#define BLE(STR) color_str(STR, LOG_COLOR::FORE_BLE, LOG_COLOR::BACK_ORG)
#define GRN(STR) color_str(STR, LOG_COLOR::FORE_GRN, LOG_COLOR::BACK_ORG)
#define YLW(STR) color_str(STR, LOG_COLOR::FORE_YLW, LOG_COLOR::BACK_ORG)
#define RED(STR) color_str(STR, LOG_COLOR::FORE_RED, LOG_COLOR::BACK_ORG)
#define PRP(STR) color_str(STR, LOG_COLOR::FORE_PRP, LOG_COLOR::BACK_ORG)

enum class LOG_LVL
{
    DBUG = 4,
    INFO = 3,
    WARN = 2,
    ERRO = 1,
    FATL = 0,
};

template<typename... varlen_type>
void print_varlen_msgs(std::string file, int line, LOG_LVL level, varlen_type... msgs);
template<typename... varlen_type>
inline void print_varlen_msgs(std::string file, int line, LOG_LVL level, varlen_type... msgs) {
    std::ostringstream oss;

    auto now = std::chrono::system_clock::now();
    std::time_t time = std::chrono::system_clock::to_time_t(now);  
    std::tm* timeinfo = std::localtime(&time); 
    oss << std::put_time(timeinfo, "%Y-%m-%d %H:%M:%S") << ' ';

    std::string prefix = "[NONE]";
    switch (level)
    {
    case LOG_LVL::DBUG:
        prefix = BLE("[DBUG]");
        break;
    
    case LOG_LVL::INFO:
        prefix = GRN("[INFO]");
        break;
    
    case LOG_LVL::WARN:
        prefix = YLW("[WARN]");
        break;

    case LOG_LVL::ERRO:
        prefix = RED("[ERRO]");
        break;
    
    case LOG_LVL::FATL:
        prefix = PRP("[FATL]");
        break;
    
    default:
        break;
    }
    oss << prefix << ' ';

    ((oss << msgs << ' '), ...) << std::endl;
    oss << "    " << file << ' ' << line << std::endl;

    std::cout << oss.str();
}
// in case that LOG doesn't receive any strings.
inline void print_varlen_msgs(std::string file, int line, LOG_LVL level)
{
    print_varlen_msgs(file, line, level, "");
}

#define LOG(LEVEL, ...) print_varlen_msgs(__FILE__, __LINE__, LEVEL, ## __VA_ARGS__)

#endif // log.h
