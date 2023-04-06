# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.16)

project(hello VERSION 1.0 LANGUAGES CXX)

find_package(Qt6 6.2 COMPONENTS Quick Gui REQUIRED)

qt_standard_project_setup(REQUIRES 6.5)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

qt_add_executable(myapp
    main.cpp
)

qt_add_qml_module(myapp
    URI hello
    QML_FILES
        main.qml
        FramedImage.qml
    RESOURCES
        img/world.png
)

target_link_libraries(myapp PRIVATE Qt6::Gui Qt6::Quick)
