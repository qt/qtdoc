# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(addressbookclient LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/${PROJECT_NAME}")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

qt_add_executable(addressbookclient
    addressbookmodel.h addressbookmodel.cpp
    restaccessmanager.h restaccessmanager.cpp
    main.cpp
)

set(qml_files
    "qml/main.qml"
)

qt_add_resources(addressbookclient "qml"
    PREFIX
        "/"
    FILES
        ${qml_files}
)

set_target_properties(addressbookclient PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

qt_add_qml_module(addressbookclient
    URI AddressBookModel
    VERSION 1.0
    QML_FILES
        "qml/main.qml"
    NO_RESOURCE_TARGET_PATH
)

target_link_libraries(addressbookclient PRIVATE
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::Quick
)

install(TARGETS addressbookclient
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
