# user should be responsible for installing the dynamic
# library that they used to link with any exe bin



# ============================= main =============================
SET(lib_inn_static)
SET(lib_inn_shared)
SET(lib_ext_static)
SET(lib_ext_shared)
SET(
    lib_all
    ${lib_inn_static}
    ${lib_inn_shared}
    ${lib_ext_static}
    ${lib_ext_shared}
)
ADD_EXECUTABLE(main main.cpp)
IF(lib_all)
    TARGET_LINK_LIBRARIES(main ${lib_all})
    # move dll/so to bin dir
    # for inner lib and external static
    INSTALL(
        TARGETS ${lib_inn}
        RUNTIME DESTINATION bin
        ARCHIVE DESTINATION lib
    )
ENDIF()
INSTALL(TARGETS main RUNTIME DESTINATION bin)




# ============================= learnopengl =============================
SET(
    learnopengl_src_list
    learnopengl/triangle.cpp
    learnopengl/texture.cpp
    learnopengl/transform.cpp
    learnopengl/coordinate.cpp
    learnopengl/camera.cpp
    learnopengl/framebuffer.cpp
    learnopengl/model_load.cpp
)

SET(lib_inn_static)
SET(lib_inn_shared glad stb_image)
SET(lib_ext_static opengl32)
SET(lib_ext_shared glfw3 assimp-vc143-mtd)
SET(
    lib_all
    ${lib_inn_static}
    ${lib_inn_shared}
    ${lib_ext_static}
    ${lib_ext_shared}
)

FOREACH(_src_file ${learnopengl_src_list})
    GET_FILENAME_COMPONENT(_src_name ${_src_file} NAME_WE)
    ADD_EXECUTABLE(${_src_name} ${_src_file})
    IF(lib_all)
        TARGET_LINK_LIBRARIES(${_src_name} ${lib_all})
    ENDIF()
    INSTALL(TARGETS ${_src_name} RUNTIME DESTINATION bin)
ENDFOREACH()

IF(lib_all)
    # move dll/so to bin dir
    # for internal targets
    INSTALL(
        TARGETS ${lib_inn_shared} ${lib_inn_static}
        RUNTIME DESTINATION bin
        ARCHIVE DESTINATION lib
    )
    # for external targets
    INSTALL(
        IMPORTED_RUNTIME_ARTIFACTS ${lib_ext_shared}
    )
ENDIF()


# ============================= shadertoy =============================
SET(
    shadertoy_src_list
    shadertoy/isovalues.cpp
    shadertoy/simple.cpp
)

SET(lib_inn_static)
SET(lib_inn_shared glad stb_image)
SET(lib_ext_static opengl32)
SET(lib_ext_shared glfw3 assimp-vc143-mtd)
SET(
    lib_all
    ${lib_inn_static}
    ${lib_inn_shared}
    ${lib_ext_static}
    ${lib_ext_shared}
)

FOREACH(_src_file ${shadertoy_src_list})
    GET_FILENAME_COMPONENT(_src_name ${_src_file} NAME_WE)
    ADD_EXECUTABLE(${_src_name} ${_src_file})
    IF(lib_all)
        TARGET_LINK_LIBRARIES(${_src_name} ${lib_all})
    ENDIF()
    INSTALL(TARGETS ${_src_name} RUNTIME DESTINATION bin)
ENDFOREACH()

IF(lib_all)
    # move dll/so to bin dir
    # for internal targets
    INSTALL(
        TARGETS ${lib_inn_shared} ${lib_inn_static}
        RUNTIME DESTINATION bin
        ARCHIVE DESTINATION lib
    )
    # for external targets
    INSTALL(
        IMPORTED_RUNTIME_ARTIFACTS ${lib_ext_shared}
    )
ENDIF()
