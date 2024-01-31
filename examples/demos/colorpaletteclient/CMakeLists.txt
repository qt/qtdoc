# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(colorpaletteclient LANGUAGES CXX)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/${PROJECT_NAME}")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)
qt_standard_project_setup(REQUIRES 6.6)

qt_add_executable(colorpaletteclient
    main.cpp
)

set_target_properties(colorpaletteclient PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

add_subdirectory(QtExampleStyle)

qt_add_qml_module(colorpaletteclient
    URI ColorPalette
    QML_FILES
        ColorPalette/Main.qml
        ColorPalette/ServerSelection.qml
        ColorPalette/ColorView.qml
        ColorPalette/ColorDialogEditor.qml
        ColorPalette/ColorDialogDelete.qml
        ColorPalette/UserMenu.qml
    SOURCES
        abstractresource.h
        util.h util.cpp
        basiclogin.h basiclogin.cpp
        restservice.h restservice.cpp
        paginatedresource.h paginatedresource.cpp
        restaccessmanager.h restaccessmanager.cpp
    RESOURCES
        icons/qt.png
        icons/testserver.png
        icons/userMask.svg
        icons/close.svg
        icons/delete.svg
        icons/dots.svg
        icons/edit.svg
        icons/login.svg
        icons/logout.svg
        icons/ok.svg
        icons/update.svg
        icons/user.svg
        icons/plus.svg
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

include(../shared/QtBundleQmlModuleForMacOS.cmake)
add_qml_module_to_macos_app_bundle("colorpaletteclient" "qtexamplestyle")
