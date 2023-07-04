# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(documentviewer LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets
             OPTIONAL_COMPONENTS PrintSupport Pdf PdfWidgets)

qt_standard_project_setup()

add_compile_definitions(QT_NO_CAST_FROM_ASCII)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

if(TARGET Qt6::PrintSupport)
    add_compile_definitions(QT_DOCUMENTVIEWER_PRINTSUPPORT)
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/documentviewer")

add_subdirectory(app)
add_subdirectory(plugins)
