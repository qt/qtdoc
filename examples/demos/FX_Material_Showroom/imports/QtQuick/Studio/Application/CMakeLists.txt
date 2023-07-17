# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

qt_add_library(QQS_App
    STATIC
)

qt_add_qml_module(QQS_App
    URI QtQuick.Studio.Application
    VERSION 1.0
    CLASS_NAME QQS_AppPlugin
    SOURCES
        quickstudioapplication.cpp quickstudioapplication_p.h
)

target_link_libraries(QQS_App PRIVATE
    Qt6::Qml
    Qt6::Quick
)
