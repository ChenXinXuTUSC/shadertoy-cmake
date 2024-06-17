#ifndef CLOG_H
#define CLOG_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#define true 1
#define false 0
#define nullptr NULL

// MSVC default export behaviour is different from
// GNU, it only exports  normal  functions,  other
// type of data need to be exported explicitly
#if defined(C_COMPILER_ID_MSVC)
    #if defined(DLLCOMPILE)
        #define DLLUSAGE __declspec(dllexport)
    #else
        #define DLLUSAGE __declspec(dllimport)
    #endif
#else
    #define DLLUSAGE
#endif

enum LOG_COLOR_C
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
char* color_str(int fore_code, int back_code, const char* str);

#define BUF_SZE 1024
DLLUSAGE extern char log_buf[BUF_SZE];
DLLUSAGE extern char tmp_buf[BUF_SZE];

#define BLE(STR) color_str(FORE_BLE, BACK_ORG, STR)
#define GRN(STR) color_str(FORE_GRN, BACK_ORG, STR)
#define YLW(STR) color_str(FORE_YLW, BACK_ORG, STR)
#define RED(STR) color_str(FORE_RED, BACK_ORG, STR)
#define PRP(STR) color_str(FORE_PRP, BACK_ORG, STR)


char* log_prefix(int level);
char* log_suffix(const char* file, int line);

enum LOG_LVL_C
{
    DBUG = 4,
    INFO = 3,
    WARN = 2,
    ERRO = 1,
    FATL = 0,
};

#define LOG(LEVEL, FMT, ...) \
    { \
        log_prefix(LEVEL); \
        sprintf_s(log_buf + strlen(log_buf), BUF_SZE, FMT, ## __VA_ARGS__); \
        log_suffix(__FILE__, __LINE__); \
        printf("%s\n", log_buf); \
    }

#endif // clog.h
