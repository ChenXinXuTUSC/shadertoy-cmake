#ifndef DUMMY_H
#define DUMMY_H

// MSVC default export behaviour is different from
// GNU, it only exports  normal  functions,  other
// type of data need to be exported explicitly
#if defined(CXX_COMPILER_ID_MSVC)
    // MSVC expansion doesn't need
    // any additional header files
    #if defined(DLLCOMPILE)
        #define DLLUSAGE __declspec(dllexport)
    #else
        #define DLLUSAGE __declspec(dllimport)
    #endif
#else
    #define DLLUSAGE
#endif

DLLUSAGE extern int dumyi;

void print_msg(const char* msg);

#endif
