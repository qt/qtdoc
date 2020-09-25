# Generated from qtdoc.pro.

cmake_minimum_required(VERSION 3.15.0)

include(.cmake.conf)
project(QtDoc # special case
    VERSION "${QT_REPO_MODULE_VERSION}"
    DESCRIPTION "Qt Documentation and examples" # special case
    HOMEPAGE_URL "https://qt.io/"
    LANGUAGES CXX C
)

find_package(Qt6 ${PROJECT_VERSION} CONFIG REQUIRED COMPONENTS BuildInternals Core Gui) # special case
find_package(Qt6 ${PROJECT_VERSION} CONFIG OPTIONAL_COMPONENTS Qml Quick Test Sql) # special case for tests

# special case begin
qt_build_repo_begin()

if(NOT QT_BUILD_STANDALONE_TESTS)
    add_subdirectory(doc)
    add_subdirectory(doc/src/cmake)
    add_dependencies(Doc CMakeDoc)

    # Dummy file that needs to be installed, to circumvent Coin skipping builds of standalone
    # tests due to not having anything to upload as an artifact.
    qt_configure_file(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/qtdoc_dummy_file.txt" CONTENT " ")
    qt_install(FILES "${CMAKE_CURRENT_BINARY_DIR}/qtdoc_dummy_file.txt" DESTINATION "${INSTALL_MKSPECSDIR}")
endif()

if(BUILD_TESTING AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/tests/CMakeLists.txt")
    add_subdirectory(tests)

    if(QT_NO_MAKE_TESTS)
        set_property(DIRECTORY tests PROPERTY EXCLUDE_FROM_ALL TRUE)
    endif()
endif()

if(BUILD_EXAMPLES AND BUILD_SHARED_LIBS
            AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/examples/CMakeLists.txt"
            AND NOT QT_BUILD_STANDALONE_TESTS)
    add_subdirectory(examples)

    if(QT_NO_MAKE_EXAMPLES)
        set_property(DIRECTORY examples PROPERTY EXCLUDE_FROM_ALL TRUE)
    endif()
endif()

qt_build_repo_end()
# special case end
