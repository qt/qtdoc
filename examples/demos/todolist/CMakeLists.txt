#Copyright (C) 2023 The Qt Company Ltd.
#SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

cmake_minimum_required(VERSION 3.18)

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/todolist")

project(ToDoListApp LANGUAGES CXX)

find_package(Qt6 6.5 COMPONENTS Gui Qml Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(ToDoListApp src/main.cpp)

qt_add_resources(ToDoListApp "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

include(qmlmodules.cmake)

target_link_libraries(ToDoListApp PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::Qml
    Qt6::QuickControls2
)

install(TARGETS ToDoListApp
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
