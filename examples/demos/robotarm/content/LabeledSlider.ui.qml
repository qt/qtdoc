// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls

Slider {
    property string labelText: qsTr("Text")
    stepSize: 1

    Label {
        text: parent.labelText
        anchors.left: parent.left
        anchors.bottom: parent.top
        bottomPadding: -12
    }
    Label {
        text: parent.value
        anchors.right: parent.right
        anchors.bottom: parent.top
        bottomPadding: -12
    }
}
