# Generated from qtdoc.pro.

cmake_minimum_required(VERSION 3.15.0)

project(QtDoc
    VERSION 6.0.0
    DESCRIPTION "Qt Documentation and examples" # special case
    HOMEPAGE_URL "https://qt.io/"
    LANGUAGES CXX C
)

find_package(Qt6 ${PROJECT_VERSION} CONFIG REQUIRED COMPONENTS BuildInternals Core Gui) # special case
find_package(Qt6 ${PROJECT_VERSION} CONFIG OPTIONAL_COMPONENTS Qml Quick Test) # special case for tests

# special case begin
qt_build_repo_begin()
add_subdirectory(examples)
add_subdirectory(doc)
add_subdirectory(tests)
qt_build_repo_end()
# special case end
