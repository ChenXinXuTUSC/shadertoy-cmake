SET(lib_type SHARED)
# SET(lib_type STATIC)

# build dummy
FILE(
    GLOB module_dummy_src_list
    dummy/*.cpp
    dummy/*.cc
    dummy/*.c
)
PRINT_LIST("${module_dummy_src_list}" "MODULE [dummy] SRC" "")
ADD_LIBRARY(dummy ${lib_type} ${module_dummy_src_list})
INSTALL(
    TARGETS dummy 
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
)

# build utils
FILE(
    GLOB module_utils_src_list
    utils/*.cpp
    utils/*.cc
    utils/*.c
)
PRINT_LIST("${module_utils_src_list}" "MODULE [utils] SRC" "")
ADD_LIBRARY(utils ${lib_type} ${module_utils_src_list})
IF(lib_type STREQUAL "SHARED")
    # this is for MSVC usage to export global data symbols
    # CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS only exports method
    IF(CMAKE_SYSTEM_NAME STREQUAL "Windows" AND CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        TARGET_COMPILE_DEFINITIONS(
            utils
            PRIVATE DLLCOMPILE # can not use PUBLIC attr? That's weird...
        )
    ENDIF()
ENDIF()
INSTALL(
    TARGETS utils 
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
)

# build other
FILE(
    GLOB module_other_src_list
    ./*.cpp
    ./*.cc
    ./*.c
)
PRINT_LIST("${module_other_src_list}" "MODULE [other] SRC" "")
ADD_LIBRARY(other ${lib_type} ${module_other_src_list})
INSTALL(
    TARGETS other 
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
)



# build glad
FILE(
    GLOB module_glad_src_list
    glad/*.cpp
    glad/*.cc
    glad/*.c
)
PRINT_LIST("${module_glad_src_list}" "MODULE [glad] SRC" "")
ADD_LIBRARY(glad ${lib_type} ${module_glad_src_list})
IF(lib_type STREQUAL "SHARED")
    TARGET_COMPILE_DEFINITIONS(
        glad
        PUBLIC GLAD_GLAPI_EXPORT
        PRIVATE GLAD_GLAPI_EXPORT_BUILD
    )
ENDIF()
INSTALL(
    TARGETS glad
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
)

# build stb_image
FILE(
    GLOB module_stb_image_src_list
    stb_image/*.cpp
    stb_image/*.cc
    stb_image/*.c
)
PRINT_LIST("${module_stb_image_src_list}" "MODULE [stb_image] SRC" "")
ADD_LIBRARY(stb_image ${lib_type} ${module_stb_image_src_list})
INSTALL(
    TARGETS stb_image
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
)
