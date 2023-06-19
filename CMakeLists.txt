# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

# Generated from qtdoc.pro.

cmake_minimum_required(VERSION 3.16)

include(.cmake.conf)
project(QtDoc # special case
    VERSION "${QT_REPO_MODULE_VERSION}"
    DESCRIPTION "Qt Documentation and examples" # special case
    HOMEPAGE_URL "https://qt.io/"
    LANGUAGES CXX C
)

find_package(Qt6 ${PROJECT_VERSION} CONFIG REQUIRED COMPONENTS BuildInternals Core)
find_package(Qt6 ${PROJECT_VERSION} QUIET CONFIG
    OPTIONAL_COMPONENTS
        Gui
        Widgets
        PrintSupport
        Qml
        Quick
        Quick3D
        Quick3DPhysics
        Test
        Sql
        Network
        QuickControls2
        QmlXmlListModel
)
qt_internal_project_setup()

# special case begin
qt_build_repo_begin()

if(NOT QT_BUILD_STANDALONE_TESTS)
    add_subdirectory(doc)
    add_subdirectory(doc/src/cmake)
    add_subdirectory(doc/src/platformintegration)
    add_dependencies(QtDoc qtcmake)
    add_dependencies(QtDoc qtplatformintegration)

    # Dummy file that needs to be installed, to circumvent Coin skipping builds of standalone
    # tests due to not having anything to upload as an artifact.
    qt_configure_file(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/qtdoc_dummy_file.txt" CONTENT " ")
    qt_install(FILES "${CMAKE_CURRENT_BINARY_DIR}/qtdoc_dummy_file.txt" DESTINATION "${INSTALL_MKSPECSDIR}")
endif()

if(QT_BUILD_TESTS AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/tests/CMakeLists.txt")
    add_subdirectory(tests)

    if(NOT QT_BUILD_TESTS_BY_DEFAULT)
        set_property(DIRECTORY tests PROPERTY EXCLUDE_FROM_ALL TRUE)
    endif()
endif()

if(QT_BUILD_EXAMPLES AND BUILD_SHARED_LIBS
            AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/examples/CMakeLists.txt"
            AND NOT QT_BUILD_STANDALONE_TESTS)
    add_subdirectory(examples)

    if(NOT QT_BUILD_EXAMPLES_BY_DEFAULT)
        set_property(DIRECTORY examples PROPERTY EXCLUDE_FROM_ALL TRUE)
    endif()
endif()

qt_build_repo_end()
# special case end
