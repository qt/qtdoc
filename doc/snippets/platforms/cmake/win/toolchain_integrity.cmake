#generic
set(CMAKE_SYSTEM_NAME Integrity)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_CROSSCOMPILING True)

#path to installed GHS compiler for WIN10
set(TARGET_ROOT_PATH "C:/Users/user/ghs_pack/es7_dev_env/hlos_dev_boot")
set(CMAKE_BUILD_TYPE "Release")

set(GHS_COMPILER C:/ghs/comp_202014/cxintarm64.exe)
set(CMAKE_C_COMPILER ${GHS_COMPILER})
set(CMAKE_CXX_COMPILER ${GHS_COMPILER})
set(CMAKE_ASM_COMPILER ${GHS_COMPILER})

set(EGL_FOUND True)
set(UNIX True)

set (CMAKE_C_COMPILE_FEATURES c_std_99)
set (CMAKE_CXX_COMPILE_FEATURES
cxx_alias_templates
cxx_alignas
cxx_alignof
cxx_attributes
cxx_auto_type
cxx_constexp
cxx_decltype
cxx_delegating_constructors
cxx_explicit_conversions
cxx_extern_templates
cxx_inheriting_constructors
cxx_lambdas
cxx_noexcept
cxx_nonstatic_member_init
cxx_nullptr
cxx_override
cxx_range_for
cxx_raw_string_literals
cxx_reference_qualified_functions
cxx_rvalue_references
cxx_static_assert
cxx_std_17
cxx_thread_local
cxx_unicode_literals
cxx_uniform_initialization
cxx_unrestricted_unions
cxx_variadic_macros
cxx_variadic_templates)

if (NOT DEFINED CMAKE_FIND_ROOT_PATH_MODE_PROGRAM)
    set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
endif()
if (NOT DEFINED CMAKE_FIND_ROOT_PATH_MODE_LIBRARY)
    set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
endif()
if (NOT DEFINED CMAKE_FIND_ROOT_PATH_MODE_PACKAGE)
    set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
endif()
if (NOT DEFINED CMAKE_FIND_ROOT_PATH_MODE_INCLUDE)
    set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
endif()

set(CMAKE_FIND_ROOT_PATH ${TARGET_ROOT_PATH})

#base
set(CMAKE_C_FLAGS  "-bsp $ENV{INTEGRITY_BSP} -os_dir $ENV{INTEGRITY_DIR} -non_shared -startfile_dir=$ENV{INTEGRITY_DIR}/libs/$ENV{INTEGRITY_BSP}/$ENV{INTEGRITY_BUILD_TARGET} --rtos_library_directory=libs/$ENV{INTEGRITY_BSP}/$ENV{INTEGRITY_BUILD_TARGET} --rtos_library_directory=libs/arm64/$ENV{INTEGRITY_BUILD_TARGET} -bigswitch -DINTEGRITY -llibivfs.a -llibposix.a -llibpaged_alloc.a -llibnet.a -llibsocket.a")
set(CMAKE_C_FLAGS_DEBUG "-g -Omaxdebug")
set(CMAKE_C_FLAGS_RELEASE "-Ospeed -Olink -Omax")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --signed_fields --diag_suppress=1,82,228,236,381,611,961,997,1795,1931,1974,3148 --c++17 --thread_local_storage --exceptions --defer_parse_function_templates")

set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} --signed_fields --no_implicit_include --link_once_templates -non_shared --new_outside_of_constructor -I $ENV{QC_MULTIMEDIA_INC_DIR}")
set(CMAKE_CXX_FLAGS_DEBUG ${CMAKE_C_FLAGS_DEBUG})
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -L$ENV{TARGET_ROOT_PATH} -L$ENV{TARGET_ROOT_PATH}/apps/ghs_apps_proc/qc_bsp/out/rel/libs/multimedia/graphics -L$ENV{TARGET_ROOT_PATH}/apps/ghs_apps_proc/qc_bsp/out/rel/libs/base -L$ENV{TARGET_ROOT_PATH}/apps/ghs_apps_proc/qc_bsp/AMSS/multimedia/graphics/opengl/esx/build/integrity/prebuilt -L$ENV{TARGET_ROOT_PATH}/apps/ghs_apps_proc/qc_bsp/out/rel/libs/platform -L$ENV{TARGET_ROOT_PATH}/apps/ghs_apps_proc/qc_bsp/out/rel/libs/multimedia/display/ --commons")
set(CMAKE_FIND_LIBRARY_PREFIXES "lib")
set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")

set(BUILD_SHARED_LIBS OFF)
set(QT_CFLAGS_OPTIMIZE_FULL "-Ospeed -Olink -Omax")

set(EGL_INCLUDE_DIR $ENV{GL_INC_DIR})
set(PKG_EGL_LIBRARY_DIRS ${TARGET_ROOT_PATH})

set(GLESv2_INCLUDE_DIR $ENV{GL_INC_DIR})
set(OPENGL_INCLUDE_DIR $ENV{GL_INC_DIR})

set(EGL_LIBRARY ${TARGET_ROOT_PATH}/libeglmegapack.a)
set(GLESv2_LIBRARY ${TARGET_ROOT_PATH}/libeglmegapack.a)
set(OPENGL_opengl_LIBRARY ${TARGET_ROOT_PATH}/libeglmegapack.a)

# Command is required to fix CMake WIN bug https://gitlab.kitware.com/cmake/cmake/-/issues/22933
set(CMAKE_CXX_COMPILER_PREDEFINES_COMMAND ${CMAKE_CXX_COMPILER})
list(APPEND CMAKE_CXX_COMPILER_PREDEFINES_COMMAND -bsp $ENV{INTEGRITY_BSP} -os_dir $ENV{INTEGRITY_DIR} -E -dM "${CMAKE_ROOT}/Modules/CMakeCXXCompilerABI.cpp")

# Set format for creating static library
set(CMAKE_CXX_CREATE_STATIC_LIBRARY "${CMAKE_CXX_COMPILER} ${CMAKE_CXX_FLAGS} <LINK_FLAGS> -archive -o <TARGET> <OBJECTS> -keep_objs")
set(CMAKE_C_CREATE_STATIC_LIBRARY   "${CMAKE_CXX_COMPILER} ${CMAKE_C_FLAGS} <LINK_FLAGS> -archive -o <TARGET> <OBJECTS> -keep_objs")

# Set format to create executables
set(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_CXX_COMPILER} ${CMAKE_CXX_FLAGS} <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_C_LINK_EXECUTABLE   "${CMAKE_CXX_COMPILER} ${CMAKE_C_FLAGS} <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
