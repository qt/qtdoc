# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(clocks LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/clocks")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

qt_add_executable(clocks
    main.cpp
)

set_target_properties(clocks PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(clocks PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

# Resources:
set(clocks_resource_files
    "clocks.qml"
    "content/Clock.qml"
    "content/arrow.png"
    "content/background.png"
    "content/center.png"
    "content/clock-night.png"
    "content/clock.png"
    "content/hour.png"
    "content/minute.png"
    "content/quit.png"
    "content/second.png"
)

qt_add_resources(clocks "clocks"
    PREFIX
        "/demos/clocks"
    FILES
        ${clocks_resource_files}
)

install(TARGETS clocks
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
