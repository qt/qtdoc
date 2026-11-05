# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

qt_add_library(abstractviewer
    abstractviewer.cpp abstractviewer.h
    translator.cpp translator.h
    abstractviewerglobal.h logging.h
    viewerinterfaces.h
)

target_compile_definitions(abstractviewer PRIVATE BUILD_ABSTRACTVIEWER_LIB)

target_include_directories(abstractviewer INTERFACE .)

target_link_libraries(abstractviewer PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
)

if(TARGET Qt6::PrintSupport)
    target_link_libraries(abstractviewer PUBLIC Qt6::PrintSupport)
    target_compile_definitions(abstractviewer PUBLIC
        DOCUMENTVIEWER_PRINTSUPPORT
    )
endif()
