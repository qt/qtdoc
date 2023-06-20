# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

cmake_minimum_required(VERSION 3.16)

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/thermostat")

project(ThermostatApp LANGUAGES CXX)

find_package(Qt6 6.5 REQUIRED COMPONENTS Gui Qml Quick QuickControls2 Svg Charts)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(ThermostatApp src/main.cpp)

qt_add_resources(ThermostatApp "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

include(qmlmodules)

target_link_libraries(ThermostatApp PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::Qml
    Qt6::Svg
    Qt6::Charts
    Qt6::QuickControls2
)

install(TARGETS ThermostatApp
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
