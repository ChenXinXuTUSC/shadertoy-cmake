FUNCTION(FIND_LIBS lib_dir suffix return_lib_name_list return_lib_path_list)
    UNSET(return_lib_name_list CACHE)
    UNSET(return_lib_path_list CACHE)

    FILE(
        GLOB lib_path_list
        ${lib_dir}/*.${suffix}
    )

    FOREACH(_lib_path ${lib_path_list})
        GET_FILENAME_COMPONENT(_lib_name ${_lib_path} NAME_WE)
        # MESSAGE("_lib_name ${_lib_name}")
        LIST(APPEND lib_name_list ${_lib_name})
    ENDFOREACH(_lib_path ${lib_path_list})

    # MESSAGE("lib_name_list ${lib_name_list}")
    # MESSAGE("lib_path_list ${lib_path_list}")
    SET(return_lib_name_list ${lib_name_list} PARENT_SCOPE)
    SET(return_lib_path_list ${lib_path_list} PARENT_SCOPE)
ENDFUNCTION()

FUNCTION(MAKE_LIBS_TARGET lib_name_list lib_path_list lib_type)
    # MESSAGE("DEBUG lib_name_list=${lib_name_list}")
    # MESSAGE("DEBUG lib_path_list=${lib_path_list}")
    # MESSAGE("DEBUG lib_type=${lib_type}")
    IF(NOT lib_type STREQUAL "SHARED" AND NOT lib_type STREQUAL "STATIC")
        MESSAGE(FATAL_ERROR "unknown lib type ${lib_type}")
    ENDIF()

    LIST(LENGTH lib_name_list num_lib_name)
    LIST(LENGTH lib_path_list num_lib_path)
    IF(NOT num_lib_name EQUAL num_lib_path)
        MESSAGE(FATAL_ERROR "number of name and path of libs not equal")
    ENDIF()

    FOREACH(i RANGE 0 ${num_lib_name})
        IF(${i} EQUAL ${num_lib_name})
            BREAK()
        ENDIF()

        LIST(GET lib_name_list ${i} _lib_name)
        LIST(GET lib_path_list ${i} _lib_path)
        ADD_LIBRARY(${_lib_name} ${lib_type} IMPORTED GLOBAL)
        SET_PROPERTY(
            TARGET ${_lib_name}
            PROPERTY IMPORTED_LOCATION ${_lib_path}
        )
        # only for windows dll, that's suck
        IF(CMAKE_SYSTEM_NAME STREQUAL "Windows" AND lib_type STREQUAL "SHARED")
            GET_FILENAME_COMPONENT(_lib_dir ${_lib_path} DIRECTORY)
            SET_PROPERTY(
                TARGET ${_lib_name}
                PROPERTY IMPORTED_IMPLIB ${_lib_dir}/${_lib_name}.lib # may be this name rule?
            )
        ENDIF()
    ENDFOREACH()

ENDFUNCTION()

FUNCTION(FIND_HDRS hdr_dir return_hdr_dir_list)
    UNSET(hdr_dir_list CACHE)
    SET(hdr_dir_list)
    FILE(
        GLOB_RECURSE hdr_path_list
        ${hdr_dir}/*.h
        ${hdr_dir}/*.hpp
    )
    SET(hdr_dir_list ${hdr_dir})
    FOREACH(_hdr_path ${hdr_path_list})
        GET_FILENAME_COMPONENT(_hdr_dir ${_hdr_path} PATH)
        LIST(APPEND hdr_dir_list ${_hdr_dir})
    ENDFOREACH(_hdr_path ${hdr_path_list})
    LIST(REMOVE_DUPLICATES hdr_dir_list)
    SET(return_hdr_dir_list ${hdr_dir_list} PARENT_SCOPE)
ENDFUNCTION()


# print list item
FUNCTION(PRINT_LIST list_item title prefix)
    IF(NOT list_item OR (list_item STREQUAL ""))
        RETURN()
    ENDIF()
    MESSAGE("┌────────────────── ${title}")
    FOREACH(item ${list_item})
        MESSAGE("│ ${prefix} ${item}")
    ENDFOREACH()
    MESSAGE("└──────────────────]\n")
ENDFUNCTION()
