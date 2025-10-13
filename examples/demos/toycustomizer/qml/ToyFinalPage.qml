// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts

Item {
    id: root

    signal orderReviewRequested
    signal newOrderRequested

    ColumnLayout {
        spacing: ApplicationConfig.responsiveSize(100)
        anchors {
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }

        ToyImage {
            implicitHeight: ApplicationConfig.responsiveSize(460)
            implicitWidth: ApplicationConfig.responsiveSize(1000)
            source: "images/appLogo.svg"
            Layout.alignment: Qt.AlignHCenter
        }
        ToyImage {
            implicitHeight: ApplicationConfig.responsiveSize(120)
            implicitWidth: ApplicationConfig.responsiveSize(384)
            source: "images/builtWithQt.svg"
            Layout.alignment: Qt.AlignHCenter
        }
        ToyLabel {
            color: "#2269EE"
            text: qsTr("Thanks for your order!")
            font {
                bold: true
                family: "DynaPuff"
                pixelSize: ApplicationConfig.responsiveSize(120)
            }
            Layout.alignment: Qt.AlignCenter
        }
        Item {
            implicitHeight: dialogBackgroundImage.implicitHeight
            implicitWidth: dialogBackgroundImage.implicitWidth
            Layout.alignment: Qt.AlignCenter
            ToyImage {
                id: dialogBackgroundImage
                source: "images/dialogBackground.svg"
                sourceSize {
                    height: ApplicationConfig.responsiveSize(330)
                    width: ApplicationConfig.responsiveSize(1500)
                }
            }
            GridLayout {
                columns: 2
                columnSpacing: ApplicationConfig.responsiveSize(40)
                rowSpacing: ApplicationConfig.responsiveSize(100)
                anchors {
                    fill: parent
                    topMargin: ApplicationConfig.responsiveSize(260)
                }

                ToyLabel {
                    color: "#162655"
                    text: qsTr("Your order has been confirmed!")
                    textStyle: ApplicationConfig.TextStyle.H1
                    font.bold: false
                    Layout.columnSpan: 2
                    Layout.alignment: Qt.AlignCenter
                }
                ToyButton {
                    type: ToyButton.Type.Secondary
                    text: qsTr("View order")
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                    onClicked: root.orderReviewRequested()
                }
                ToyButton {
                    text: qsTr("New order")
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                    onClicked: root.newOrderRequested()
                }
                Item {
                    Layout.columnSpan: 2
                    Layout.fillHeight: true
                }
            }
        }
        Item {
            z: -1
            Layout.fillHeight: true
            Layout.fillWidth: true
            ToyImage {
                source: "images/teddyBear.png"
                sourceSize {
                    height: ApplicationConfig.responsiveSize(1720)
                    width: ApplicationConfig.responsiveSize(1280)
                }
                anchors {
                    left: parent.left
                    top: parent.top
                    topMargin: -ApplicationConfig.responsiveSize(860)
                    leftMargin: ApplicationConfig.responsiveSize(640)
                }
            }
        }
    }
}
