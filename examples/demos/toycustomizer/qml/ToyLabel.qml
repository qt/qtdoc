// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls

Item {
    id: control

    property alias text: label.text
    property alias wrapMode: label.wrapMode
    property alias color: label.color
    property alias font: label.font
    property alias textStyle: label.textStyle

    visible: text !== ""
    implicitHeight: visible ? label.lineCount * (textMetrics.tightBoundingRect.height
                                                 + ApplicationConfig.responsiveSize(8)) : 0
    implicitWidth: label.implicitWidth

    Label {
        id: label

        property int textStyle: ApplicationConfig.TextStyle.Body_L

        y: (control.height - height) / 2
        width: control.width
        color: "#162655"
        verticalAlignment: Qt.AlignVCenter
        font {
            pixelSize: ApplicationConfig.responsiveFontSize(textStyle)
            family: ApplicationConfig.fontFamily()
            bold: ApplicationConfig.isBoldText(textStyle)
        }
    }

    TextMetrics {
        id: textMetrics
        font: label.font
        text: label.text
    }
}
