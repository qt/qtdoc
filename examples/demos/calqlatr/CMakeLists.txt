# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(calqlatr LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/calqlatr")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2)

qt_add_executable(calqlatrexample WIN32 MACOSX_BUNDLE
    main.cpp
)

target_link_libraries(calqlatrexample PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
)

qt_add_qml_module(calqlatrexample
    URI demos.calqlatr
    VERSION 1.0
    QML_FILES
        "calqlatr.qml"
        "content/Display.qml"
        "content/NumberPad.qml"
        "content/CalculatorButton.qml"
        "content/calculator.js"
    RESOURCES
        "content/images/paper-edge-left.png"
        "content/images/paper-edge-right.png"
        "content/images/paper-grip.png"
    RESOURCE_PREFIX /
)
if(ANDROID)
    set_property(TARGET calqlatrexample PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
          ${CMAKE_CURRENT_SOURCE_DIR}/android)
endif()

install(TARGETS calqlatrexample
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
