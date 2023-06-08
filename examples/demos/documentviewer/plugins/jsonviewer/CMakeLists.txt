# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

qt_add_plugin(jsonviewer
    CLASS_NAME JsonViewer
    jsonviewer.cpp jsonviewer.h
)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets
                 OPTIONAL_COMPONENTS PrintSupport)

set_target_properties(jsonviewer PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/app"
)

target_include_directories(jsonviewer PRIVATE
    ../../app
)

target_link_libraries(jsonviewer PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
    abstractviewer
)

if(TARGET Qt6::PrintSupport)
    target_link_libraries(jsonviewer PRIVATE Qt6::PrintSupport)
endif()

install(TARGETS jsonviewer
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}/plugins"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}/plugins"
)

