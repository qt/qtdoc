# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(alarms LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

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
    BUNDLE  DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

qt_generate_deploy_qml_app_script(
    TARGET alarms
    OUTPUT_SCRIPT deploy_script
    MACOS_BUNDLE_POST_BUILD
    NO_UNSUPPORTED_PLATFORM_ERROR
    DEPLOY_USER_QML_MODULES_ON_UNSUPPORTED_PLATFORM
)
install(SCRIPT ${deploy_script})
