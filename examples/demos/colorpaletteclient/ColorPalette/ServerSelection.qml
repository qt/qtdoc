// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QtExampleStyle

pragma ComponentBehavior: Bound

Rectangle {
    id: root
    // A popup for selecting the server URL

    signal serverSelected()

    required property PaginatedResource colorResources
    required property PaginatedResource colorUsers
    required property RestService restPalette

    Connections {
        target: root.colorResources
        // Closes the URL selection popup once we have received data successfully
        function onDataUpdated() {
            fetchTester.stop()
            root.serverSelected()
        }
    }

    color: UIStyle.background

    ListModel {
        id: server
        ListElement {
            title: qsTr("Public REST API Test Server")
            url: "https://reqres.in/api"
            icon: "qrc:/qt/qml/ColorPalette/icons/testserver.png"
        }
        ListElement {
            title: qsTr("Qt-based REST API server")
            url: "http://127.0.0.1:49425/api"
            icon: "qrc:/qt/qml/ColorPalette/icons/qt.png"
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        Image {
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/qt/qml/ColorPalette/icons/qt.png"
            fillMode: Image.PreserveAspectFit
            Layout.preferredWidth: 40
        }

        Label {
            text: qsTr("Choose a server")
            Layout.alignment: Qt.AlignHCenter
            font.pixelSize: UIStyle.fontSizeXL
            color: UIStyle.titletextColor
        }

        component ServerListDelegate: Rectangle {
            id: serverListDelegate
            required property string title
            required property string url
            required property string icon
            required property int index

            radius: 10
            color: UIStyle.background1

            border.color: ListView.view.currentIndex === index ?
                              UIStyle.highlightColor :
                              UIStyle.buttonGrayOutline
            border.width: ListView.view.currentIndex === index ? 3 : 1

            implicitWidth: 210
            implicitHeight: 100

            Rectangle {
                id: img
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.leftMargin: 20

                width: 30
                height: 30
                radius: 15

                color: UIStyle.background
                border.color: parent.border.color
                border.width: 2

                Image {
                    anchors.centerIn: parent
                    source: serverListDelegate.icon
                    width: UIStyle.fontSizeM
                    height: UIStyle.fontSizeM
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }
            }

                Text {
                    text: parent.url

                    anchors.left: parent.left
                    anchors.top: img.bottom
                    anchors.topMargin: 10
                    anchors.leftMargin: 20
                    color: UIStyle.textColor
                    font.pixelSize: UIStyle.fontSizeS
                }
                Text {
                    text: parent.title

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    color: UIStyle.textColor
                    font.pixelSize: UIStyle.fontSizeS
                    font.bold: true
                }

                MouseArea {
                anchors.fill: parent
                onClicked: serverList.currentIndex = serverListDelegate.index;
            }
        }

        ListView {
            id: serverList
            Layout.alignment: Qt.AlignHCenter
            Layout.minimumWidth: 210 * server.count + 20
            Layout.minimumHeight: 100
            orientation: ListView.Horizontal

            model: server
            spacing: 20

            delegate: ServerListDelegate {}
        }

        Button {
            Layout.alignment: Qt.AlignHCenter
            text: root.restPalette.sslSupported ? qsTr("Connect (SSL)") : qsTr("Connect")

            buttonColor: UIStyle.highlightColor
            buttonBorderColor: UIStyle.highlightBorderColor
            textColor: UIStyle.textColor

            onClicked: {
                busyIndicatorPopup.title = (serverList.currentItem as ServerListDelegate).title
                busyIndicatorPopup.icon = (serverList.currentItem as ServerListDelegate).icon
                busyIndicatorPopup.open()

                fetchTester.test((serverList.currentItem  as ServerListDelegate).url)
            }
        }

        Timer {
            id: fetchTester
            interval: 2000

            function test(url) {
                root.restPalette.url = url
                root.colorResources.refreshCurrentPage()
                root.colorUsers.refreshCurrentPage()
                start()
            }
            onTriggered: busyIndicatorPopup.close()
        }
    }

    onVisibleChanged: {if (!visible) busyIndicatorPopup.close();}

    Popup {
        id: busyIndicatorPopup
        padding: 10
        modal: true
        focus: true
        anchors.centerIn: parent
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        property alias title: titleText.text
        property alias icon: titleImg.source

        ColumnLayout {
            id: fetchIndicator
            anchors.fill: parent

            RowLayout {
                Rectangle {
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                    radius: 200
                    border.color: UIStyle.buttonOutline
                    border.width: 5

                    Image {
                        id: titleImg
                        anchors.centerIn: parent
                        width: 25
                        height: 25
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Label {
                    id: titleText
                    text:""
                    font.pixelSize: UIStyle.fontSizeM
                    color: UIStyle.titletextColor
                }
            }

            RowLayout {
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignHCenter
                BusyIndicator {
                    running: visible
                    Layout.fillWidth: true
                }

                Label {
                    text: qsTr("Testing URL")
                    font.pixelSize: UIStyle.fontSizeS
                    color: UIStyle.textColor
                }
            }

            Button {
                Layout.alignment: Qt.AlignHCenter
                text: qsTr("Cancel")
                onClicked: {
                    busyIndicatorPopup.close()
                }
            }

        }

    }
}
