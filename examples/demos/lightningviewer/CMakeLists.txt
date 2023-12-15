# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.16)

set(APP_NAME LightningViewerExample)

project(LightningViewerExample VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick WebSockets Positioning)

qt_standard_project_setup(REQUIRES 6.5)

set(CMAKE_AUTORCC ON)
qt_add_executable(${APP_NAME}
    main.cpp
    controller.h controller.cpp
    data/laststrikeinfo.h
    data/lightningitemdata.h data/lightningitemdata.cpp
    models/lightningitemmodel.h models/lightningitemmodel.cpp
    providers/lightningprovider.h providers/lightningprovider.cpp
    resources/resources.qrc
    resources/lv_style/lv_style.qrc
)

target_link_libraries(${APP_NAME} PRIVATE
    Qt6::Quick
    Qt6::WebSockets
    Qt6::Positioning
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(${APP_NAME} PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appLightningViewer
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_INFO_PLIST "${CMAKE_CURRENT_SOURCE_DIR}/Info.plist"
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS ${APP_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
