set(TARGET_ROOT_PATH "/work/ghs/sa8155/es7/es7_dev_env/hlos_dev_boot")
set(CMAKE_BUILD_TYPE "Release")

set(CMAKE_C_COMPILER cxintarm64)
set(CMAKE_CXX_COMPILER cxintarm64)
set(CMAKE_ASM_COMPILER cxintarm64)

#generic
set(CMAKE_SYSTEM_NAME Integrity)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_CROSSCOMPILING True)

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

#base
set(CMAKE_C_FLAGS  "-bsp $ENV{INTEGRITY_BSP} -os_dir $ENV{INTEGRITY_DIR} -non_shared -startfile_dir=$ENV{INTEGRITY_DIR}/libs/$ENV{INTEGRITY_BSP}/$ENV{INTEGRITY_BUILD_TARGET} --rtos_library_directory=libs/$ENV{INTEGRITY_BSP}/$ENV{INTEGRITY_BUILD_TARGET} --rtos_library_directory=libs/arm64/$ENV{INTEGRITY_BUILD_TARGET} -bigswitch -DINTEGRITY -llibivfs.a -llibposix.a -llibpaged_alloc.a -llibnet.a -llibsocket.a")
set(CMAKE_C_FLAGS_DEBUG "-g -Omaxdebug")
set(CMAKE_C_FLAGS_RELEASE "-Ospeed -Olink -Omax -no_uvfd")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --signed_fields --diag_suppress=1,82,228,236,381,611,961,997,1795,1931,1974,3148 --c++17 --thread_local_storage --exceptions --defer_parse_function_templates")
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} --signed_fields --no_implicit_include --link_once_templates -non_shared --new_outside_of_constructor -I $ENV{QC_MULTIMEDIA_INC_DIR}")
set(CMAKE_CXX_FLAGS_DEBUG ${CMAKE_C_FLAGS_DEBUG})
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -L${TARGET_ROOT_PATH} -L${TARGET_ROOT_PATH}/apps/ghs_apps_proc/qc_bsp/out/rel/libs/multimedia/graphics -L${TARGET_ROOT_PATH}/apps/ghs_apps_proc/qc_bsp/out/rel/libs/base -L${TARGET_ROOT_PATH}/apps/ghs_apps_proc/qc_bsp/AMSS/multimedia/graphics/opengl/esx/build/integrity/prebuilt -L${TARGET_ROOT_PATH}/apps/ghs_apps_proc/qc_bsp/out/rel/libs/platform -L${TARGET_ROOT_PATH}/apps/ghs_apps_proc/qc_bsp/out/rel/libs/multimedia/display/ --commons")
set(CMAKE_FIND_LIBRARY_PREFIXES "lib")
set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
set(BUILD_SHARED_LIBS OFF)
set(CMAKE_EXE_LINKER_FLAGS "")
set(QT_CFLAGS_OPTIMIZE_FULL "-Ospeed -Olink -Omax -no_uvfd")
set(GLSLANG_OSDEP_PATH ../3rdparty/glslang/glslang/OSDependent/Unix)
set(GL_INC_DIR ${TARGET_ROOT_PATH}/apps/ghs_apps_proc/qc_bsp/AMSS/multimedia/graphics/include/public)
set(EGL_INCLUDE_DIR ${TARGET_ROOT_PATH}/apps/ghs_apps_proc/qc_bsp/AMSS/multimedia/graphics/include/public)
set(PKG_EGL_LIBRARY_DIRS ${TARGET_ROOT_PATH})
set(EGL_LIBRARY ${TARGET_ROOT_PATH}/libeglmegapack.a)
set(GLESv2_LIBRARY ${TARGET_ROOT_PATH}/libeglmegapack.a)
set(GLESv2_INCLUDE_DIR ${TARGET_ROOT_PATH}/apps/ghs_apps_proc/qc_bsp/AMSS/multimedia/graphics/include/public)
set(OPENGL_INCLUDE_DIR ${TARGET_ROOT_PATH}/apps/ghs_apps_proc/qc_bsp/AMSS/multimedia/graphics/include/public)
set(OPENGL_opengl_LIBRARY ${TARGET_ROOT_PATH}/libeglmegapack.a)
