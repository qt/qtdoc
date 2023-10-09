# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

qt_add_plugin(Q3Dviewer
    CLASS_NAME Q3DViewer
    q3dviewer.cpp q3dviewer.h
)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets
                 OPTIONAL_COMPONENTS PrintSupport)

set_target_properties(Q3Dviewer PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/app"
)

target_include_directories(Q3Dviewer PRIVATE
    ../../app
)

target_link_libraries(Q3Dviewer PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
    Qt6::Quick3D
    abstractviewer
)

if(TARGET Qt6::PrintSupport)
    target_link_libraries(Q3Dviewer PRIVATE Qt6::PrintSupport)
endif()

qt_add_resources(Q3Dviewer "qml"
    PREFIX
        "/qml"
    FILES
        q3dviewer.qml
        queryMimeTypes.qml
)

install(TARGETS Q3Dviewer
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}/plugins"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}/plugins"
)

