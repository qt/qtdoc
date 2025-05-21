// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts
import StocQt

Rectangle {
    id: rectangle
    color: "#101010"

    property bool portrait: width < height

    Rectangle {
        id: banner
        width: parent.width
        height: portrait? 70 : 0
        color: parent.color
        anchors.top: parent.top
        anchors.topMargin: 10
        visible: portrait

        Image {
            id: logoBig
            visible: root.width < root.height
            source: "images/qtLogo.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: logoSmall
            visible: root.width > root.height
            source: "images/qtLogo2.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }
    }

    GridLayout {
        id: gridLayout
        width: parent.width
        anchors.top: banner.bottom
        anchors.bottom: parent.bottom
        flow: GridLayout.TopToBottom
        rows: portrait? 2 : 1
        columns: 2
        anchors.bottomMargin: 10
        anchors.topMargin: 10

        Rectangle {
            id: infoPanel
            width: 323
            height: 307
            color: "#1d1d1d"
            radius: 10
            border.color: "#3c3535"
            border.width: 1
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.rightMargin: 22
            Layout.leftMargin: 22

            Text {
                id: infoText
                color: "#dfdfdf"
                text: qsTr("StocQt is an example application for visualising stock market trends using the QtGraphs module. The Example showcases real-time stock price data and allows users to select their preferred stock charts, explore historical trends, and toggle various timeframes. The application also allows for comparing of 5 stocks simultaneously")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                wrapMode: Text.Wrap
                anchors.topMargin: 18
                anchors.bottomMargin: 18
                anchors.leftMargin: 24
                anchors.rightMargin: 24
                font.weight: Font.Normal
                font.family: "Titillium Web"
            }
        }

        Item {
            id: methodSelect
            width: 360
            height: 187
            Layout.fillHeight: true
            Layout.fillWidth: true
            anchors.topMargin: 25

            ComboBox {
                id: comboBox
                width: infoPanel.width
                height: 33
                visible: !confirmation.visible
                anchors.left: parent.left
                anchors.top: parent.top
                leftPadding: 10
                anchors.leftMargin: 22
                anchors.topMargin: 28
                font.bold: true
                font.family: "Titillium Web"
                model: ["Offline Data", "Live Data"]

                onActivated: {
                    if (currentIndex === 0)
                        StockEngine.setUseLiveData(false)
                    if (currentIndex === 1) {
                        confirmation.visible = true
                    }
                }

                background: Rectangle {
                    implicitWidth: comboBox.width
                    implicitHeight: comboBox.height
                    color: "#1D1D1D"
                    radius: 5
                    border.color: "#3C3535"
                }

                delegate: ItemDelegate {
                    width: comboBox.width

                    contentItem: Text {
                        text: modelData
                        verticalAlignment: Text.AlignVCenter
                        font: comboBox.font
                        color: "#f2f2f2"
                        leftPadding: 10
                    }

                    background: Rectangle {
                        implicitWidth: comboBox.width
                        implicitHeight: comboBox.height
                        color: "#1D1D1D"
                        radius: 5
                        border.color: "#3c3535"
                        border.width: comboBox.visualFocus ? 2 : 1
                    }
                }

                popup: Popup {
                    y: comboBox.height - 1
                    width: comboBox.width + 2
                    implicitHeight: contentItem.implicitHeight + 2

                    contentItem: ListView {
                        spacing: 0
                        boundsBehavior: Flickable.StopAtBounds
                        clip: true
                        implicitHeight: contentHeight
                        model: comboBox.popup.visible ? comboBox.delegateModel : null
                        ScrollIndicator.vertical: ScrollIndicator {}
                    }

                    background: Rectangle {
                        border.color: "transparent"
                        color: "transparent"
                        radius: 2
                    }
                }
            }

            Text {
                id: methodText
                color: "#f2f2f2"
                text: qsTr("Method")
                anchors.left: parent.left
                anchors.top: parent.top
                font.pixelSize: 14
                font.bold: true
                anchors.leftMargin: 20
                anchors.topMargin: 8
                font.family: "Titillium Web"
            }

            Rectangle {
                id: confirmation
                width: 361
                visible: false
                color: "#101010"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0

                Text {
                    id: liveText
                    color: "#f2f2f2"
                    text: qsTr("Live Data")
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pixelSize: 14
                    font.bold: true
                    anchors.leftMargin: 19
                    anchors.topMargin: 8
                    font.family: "Titillium Web"
                }

                Text {
                    id: helpText
                    color: "#787878"
                    text: qsTr("Please enter your API key")
                    anchors.left: liveText.left
                    anchors.top: liveText.bottom
                    font.pixelSize: 14
                    anchors.leftMargin: 0
                    anchors.topMargin: 6
                    font.family: "Titillium Web"
                }

                Text {
                    id: invalidText
                    color: "#FA8A8A"
                    text: qsTr("Invalid API key")
                    anchors.left: liveText.left
                    anchors.top: textInput.bottom
                    font.pixelSize: 14
                    anchors.leftMargin: 0
                    anchors.topMargin: 6
                    font.family: "Titillium Web"
                    visible: false
                }

                TextField {
                    id: textInput
                    width: infoPanel.width
                    height: 40
                    anchors.top: helpText.bottom
                    anchors.left: helpText.left
                    font: helpText.font
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.topMargin: 1
                    leftPadding: 12
                    placeholderText: "API Key"
                    placeholderTextColor: "#787878"

                    onTextEdited: invalidText.visible = false

                    background: Rectangle {
                        color: "#1d1d1d"
                        border.color: "#3c3535"
                    }
                }

                Rectangle{
                    id: save
                    width: 206
                    height: 30
                    anchors.top: invalidText.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: 11
                    color: "transparent"
                    Component.onCompleted: StockEngine.onApiKeyTested.connect(handleKey)

                    Image {
                        id: base
                        anchors.fill: parent
                        source: "images/save1.png"

                        Text {
                            anchors.fill: parent
                            color: "#f2f2f2"
                            text: qsTr("Save")
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.weight: Font.DemiBold
                            font.family: "Titillium Web"
                        }
                    }

                    MouseArea {
                        id: saveButton
                        anchors.fill: parent
                        onClicked: StockEngine.testApiKey(textInput.text)
                    }

                    function handleKey(keyValid) {
                        if (keyValid) {
                            invalidText.visible = false
                            confirmation.visible = false
                            StockEngine.setUseLiveData(true)
                        }
                        else {
                            confirmation.visible = true
                            invalidText.visible = true
                        }
                    }

                    states: State {
                        name: "pressed"
                        when: saveButton.pressed
                        PropertyChanges {
                            target: save
                            scale: 1.1
                        }
                    }

                    transitions: Transition {
                        NumberAnimation {
                            properties: "scale"
                            duration: 30
                            easing.type: Easing.InOutQuad
                        }
                    }
                }

                Rectangle {
                    id: cancel
                    width: 206
                    height: 30
                    color: "transparent"
                    radius: 4
                    border.color: "#bfbfbf"
                    border.width: 1
                    anchors.top: save.bottom
                    anchors.topMargin: 8
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        anchors.fill: parent
                        id: cancelText
                        color: "#f2f2f2"
                        text: qsTr("Cancel")
                        font.pixelSize: 14
                        font.weight: Font.DemiBold
                        font.family: "Titillium Web"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            comboBox.currentIndex = 0
                            confirmation.visible = false
                            invalidText.visible = false
                        }
                    }
                }
            }
        }
    }
}
