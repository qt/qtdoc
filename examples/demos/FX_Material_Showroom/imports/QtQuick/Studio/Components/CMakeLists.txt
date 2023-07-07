# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

qt_add_library(QQS_Components STATIC)

qt_add_qml_module(QQS_Components
    URI QtQuick.Studio.Components
    VERSION 1.0
    CLASS_NAME QQS_ComponentsPlugin
    QML_FILES
        ArcItem.qml
        PieItem.qml
        TriangleItem.qml
        SvgPathItem.qml
        EllipseItem.qml
        FlipableItem.qml
        RectangleItem.qml
        RegularPolygonItem.qml
        BorderItem.qml
        IsoItem.qml
        GroupItem.qml
        ArcArrow.qml
        StraightArrow.qml
)
