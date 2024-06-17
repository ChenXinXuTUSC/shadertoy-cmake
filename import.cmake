# 包含头文件目录
FIND_HDRS(include return_hdr_dir_list)
PRINT_LIST("${return_hdr_dir_list}" "HEADER" "")
INCLUDE_DIRECTORIES(${return_hdr_dir_list})

SET(lib_shared_suffix "dll") # linux: so
SET(lib_static_suffix "lib") # linux: a

SET(lib_import_shared_list)
SET(lib_import_static_list)

LINK_DIRECTORIES(lib/glfw3)
FIND_LIBS(lib/glfw3 ${lib_shared_suffix} return_lib_name_list return_lib_path_list)
MAKE_LIBS_TARGET("${return_lib_name_list}" "${return_lib_path_list}" SHARED)
LIST(APPEND lib_import_shared_list ${return_lib_name_list})

LINK_DIRECTORIES(lib/assimp)
FIND_LIBS(lib/assimp ${lib_shared_suffix} return_lib_name_list return_lib_path_list)
MAKE_LIBS_TARGET("${return_lib_name_list}" "${return_lib_path_list}" SHARED)
LIST(APPEND lib_import_shared_list ${return_lib_name_list})


LINK_DIRECTORIES(lib/opengl32)
FIND_LIBS(lib/opengl32 ${lib_static_suffix} return_lib_name_list return_lib_path_list)
MAKE_LIBS_TARGET("${return_lib_name_list}" "${return_lib_path_list}" STATIC)
LIST(APPEND lib_import_static_list ${return_lib_name_list})

PRINT_LIST("${lib_import_shared_list}" "IMPORT LIB SHARED" "")
PRINT_LIST("${lib_import_static_list}" "IMPORT LIB STATIC" "")
