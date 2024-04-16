# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(LightningViewerExample VERSION 1.0 LANGUAGES CXX)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/${PROJECT_NAME}")

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.6)

add_subdirectory(LightningViewer)
add_subdirectory(LightningViewerStyle)

qt_add_executable(${PROJECT_NAME} WIN32
    main.cpp
)

target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Quick
    Qt6::QuickControls2
    LightningViewer
    LightningViewerStyle
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE TRUE
    MACOSX_BUNDLE_GUI_IDENTIFIER "io.qt.examples.LightningViewer"
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_INFO_PLIST "${CMAKE_CURRENT_SOURCE_DIR}/Info.plist"
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
)

install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)

if (ANDROID)
    include(FetchContent)
    FetchContent_Declare(
        android_openssl
        DOWNLOAD_EXTRACT_TIMESTAMP true
        URL https://github.com/KDAB/android_openssl/archive/refs/heads/master.zip
    )
    FetchContent_MakeAvailable(android_openssl)
    include(${android_openssl_SOURCE_DIR}/android_openssl.cmake)
    add_android_openssl_libraries(LightningViewerExample)
endif()
