# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

# Generated from examples.pro.

#####################################################################
## tst_examples Test:
#####################################################################

if(NOT QT_BUILD_STANDALONE_TESTS AND NOT QT_BUILDING_QT)
    cmake_minimum_required(VERSION 3.16)
    project(tst_examples LANGUAGES CXX)
    find_package(Qt6BuildInternals REQUIRED COMPONENTS STANDALONE_TEST)
endif()

qt_internal_add_test(tst_examples
    SOURCES
        tst_examples.cpp
    DEFINES
        SRCDIR="${CMAKE_CURRENT_SOURCE_DIR}"
    LIBRARIES
        Qt6::CorePrivate
        Qt6::Gui
        Qt6::GuiPrivate
        Qt6::QmlPrivate
        Qt6::QuickPrivate
)

#### Keys ignored in scope 1:.:.:examples.pro:<TRUE>:
# testcase.timeout = "400"

## Scopes:
#####################################################################

qt_internal_extend_target(tst_examples CONDITION NOT TARGET Qt6::XmlPatterns
    DEFINES
        QT_NO_XMLPATTERNS
)
