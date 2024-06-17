# test log
FILE(
    GLOB test_log_list
    log/*.cpp
    log/*.cc
    log/*.c
)
PRINT_LIST("${test_log_list}" "TEST [LOG] SRC" "")
FOREACH(_test_src ${test_log_list})
    SET(lib_inn utils dummy other)
    SET(lib_ext)
    SET(lib_all ${lib_inn} ${lib_ext})
    GET_FILENAME_COMPONENT(_test_name ${_test_src} NAME_WE)
    ADD_EXECUTABLE(${_test_name} ${_test_src})
    INSTALL(TARGETS ${_test_name} RUNTIME DESTINATION bin)
    IF(lib_all)
        TARGET_LINK_LIBRARIES(${_test_name} ${lib_all})
        # move dll/so to bin dir
        # for internal targets
        INSTALL(
            TARGETS ${lib_inn_shared} ${lib_inn_static}
            RUNTIME DESTINATION bin
            ARCHIVE DESTINATION lib
        )
    ENDIF()
ENDFOREACH(_test_src ${test_log_list})





# test misc
FILE(
    GLOB test_misc_list
    misc/*.cpp
    misc/*.cc
    misc/*.c
)
PRINT_LIST("${test_misc_list}" "TEST [misc] SRC" "")
FOREACH(_test_src ${test_misc_list})
    SET(lib_inn_static)
    SET(lib_inn_shared other dummy)
    SET(lib_ext_static)
    SET(lib_ext_shared)
    SET(
        lib_all
        ${lib_inn_static}
        ${lib_inn_shared}
        ${lib_ext_static}
        ${lib_ext_shared}
    )
    GET_FILENAME_COMPONENT(_test_name ${_test_src} NAME_WE)
    ADD_EXECUTABLE(${_test_name} ${_test_src})
    INSTALL(TARGETS ${_test_name} RUNTIME DESTINATION bin)
    IF(lib_all)
        TARGET_LINK_LIBRARIES(${_test_name} ${lib_all})
        # move dll/so to bin dir
        # for internal targets
        INSTALL(
            TARGETS ${lib_inn_shared} ${lib_inn_static}
            RUNTIME DESTINATION bin
            ARCHIVE DESTINATION lib
        )
    ENDIF()
ENDFOREACH(_test_src ${test_log_list})
