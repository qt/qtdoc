# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(colorpaletteclient LANGUAGES CXX)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/${PROJECT_NAME}")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)
qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(colorpaletteclient
    main.cpp
)

set(icon_files)
foreach(icon IN ITEMS add delete edit file_upload login logout refresh)
    foreach(scale IN ITEMS "" "@2" "@3" "@4")
        message("icons/colorpaletteclient/20x20${scale}/${icon}.png")
        list(APPEND icon_files "icons/colorpaletteclient/20x20${scale}/${icon}.png")
    endforeach()
endforeach()

set_target_properties(colorpaletteclient PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

qt_add_resources(colorpaletteclient "theme" FILES
    ${icon_files}
    icons/colorpaletteclient/index.theme
)

qt_add_qml_module(colorpaletteclient
    URI ColorPalette
    VERSION 1.0
    QML_FILES
        MainWindow.qml
    SOURCES
        abstractresource.h
        util.h util.cpp
        basiclogin.h basiclogin.cpp
        restservice.h restservice.cpp
        paginatedresource.h paginatedresource.cpp
        restaccessmanager.h restaccessmanager.cpp
)

target_link_libraries(colorpaletteclient PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

install(TARGETS colorpaletteclient
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
