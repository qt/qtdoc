# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(documentviewer LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets
             OPTIONAL_COMPONENTS PrintSupport Pdf PdfWidgets Quick3D)

qt_standard_project_setup()

add_compile_definitions(QT_NO_CAST_FROM_ASCII)

if(TARGET Qt6::PrintSupport)
    add_compile_definitions(QT_DOCUMENTVIEWER_PRINTSUPPORT)
endif()

add_subdirectory(app)
add_subdirectory(plugins)
