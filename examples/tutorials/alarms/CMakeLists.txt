# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(alarms LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/alarms")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick)

qt_add_executable(alarms
    main.cpp
)

set_target_properties(alarms PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(alarms PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
)

# Resources:
set(qml_resource_files
    "AlarmDelegate.qml"
    "AlarmDialog.qml"
    "AlarmModel.qml"
    "TumblerDelegate.qml"
    "main.qml"
)

qt_add_resources(alarms "qml"
    PREFIX
        "/alarms/"
    FILES
        ${qml_resource_files}
)

qt_add_resources(alarms "controls_conf"
    PREFIX
        "/"
    FILES
        "qtquickcontrols2.conf"
)

install(TARGETS alarms
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
