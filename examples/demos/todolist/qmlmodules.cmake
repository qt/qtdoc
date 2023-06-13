#Copyright (C) 2023 The Qt Company Ltd.
#SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

qt6_add_qml_module(ToDoListApp
    URI "Main"
    VERSION 1.0
    NO_PLUGIN
    QML_FILES Main.qml
)

add_subdirectory(content)
add_subdirectory(imports)

target_link_libraries(ToDoListApp PRIVATE
    todolist_contentplugin
    CustomControlsplugin
    CustomStyleplugin
    ToDoListplugin
)
