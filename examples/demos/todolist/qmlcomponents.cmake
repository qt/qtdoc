#Copyright (C) 2023 The Qt Company Ltd.
#SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

message("Building designer components.")

set(QT_QML_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/qml")

include(FetchContent)
FetchContent_Declare(
    ds
    GIT_TAG qds-3.9
    GIT_REPOSITORY https://code.qt.io/qt-labs/qtquickdesigner-components.git
)

FetchContent_GetProperties(ds)
FetchContent_Populate(ds)

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    QuickStudioComponentsplugin
    QuickStudioEffectsplugin
    QuickStudioApplicationplugin
    FlowViewplugin
    QuickStudioLogicHelperplugin
    QuickStudioMultiTextplugin
    QuickStudioEventSimulatorplugin
    QuickStudioEventSystemplugin
)

add_subdirectory(${ds_SOURCE_DIR} ${ds_BINARY_DIR})

target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE
  BULD_QDS_COMPONENTS=true
)
