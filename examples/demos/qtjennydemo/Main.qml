// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick
import qtjenny_consumer
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: mainWindow

    visible: true

    property string wakeLockStatus: ""
    property bool isPortrait: Screen.primaryOrientation === Qt.LandscapeOrientation ? false : true

    Popup {
        id: popup

        modal: true
        focus: true
        padding: 20
        anchors.centerIn: parent
        width: parent.width / 1.5
        closePolicy: Popup.CloseOnPressOutside

        contentItem: Text {
            id: popupText

            wrapMode: Text.WordWrap
            font.pointSize: 15
        }
    }

    BackEnd {
        id: myBackEnd

        onShowPopup: function(volumeDisabledReason) {
            popup.open()
            popupText.text = volumeDisabledReason
        }
    }

    Text {
        id: wakeLockText

        text: mainWindow.wakeLockStatus
        font.pointSize: 26
        anchors {
            bottom: mainGrid.top
            bottomMargin: mainWindow.isPortrait ? 50 : 10
            horizontalCenter: mainGrid.horizontalCenter
        }
    }

    GridLayout {
        id: mainGrid

        columns: mainWindow.isPortrait ? 1 : 2
        anchors {horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter}

        GridLayout {
            id: innerGrid

            columns: mainWindow.isPortrait ? 1 : 2
            rows: mainWindow.isPortrait ? 4 : 2
            Layout.columnSpan: mainWindow.isPortrait ? 1 : 2
            Layout.alignment: Qt.AlignHCenter

            Text {
                id: volumeControlText

                text: "Volume control"
                font.pointSize: 16
            }

            Row {
                id: volumeControlRow

                spacing: 5

                Button {
                    id: volumeUpButton

                    text: "+"
                    highlighted: true
                    enabled: !myBackEnd.isFixedVolume

                    onClicked: {
                        myBackEnd.adjustVolume(1)
                    }
                }

                Button {
                    id: volumeDownButton

                    text: "-"
                    highlighted: true
                    enabled: !myBackEnd.isFixedVolume

                    onClicked: {
                        myBackEnd.adjustVolume(0)
                    }
                }
            }

            Text {
                id: brightnessControlText

                text: "Brightness control"
                font.pointSize: 16
                Layout.topMargin: mainWindow.isPortrait ? 20 : 0
            }

            Row {
                id: brightnessControlRow

                spacing: 5

                Button {
                    id: brightnessUpButton

                    text: "+"
                    highlighted: true

                    onClicked: {
                        myBackEnd.adjustBrightness(1)
                    }
                }

                Button {
                    id: brightnessDownButton

                    text: "-"
                    highlighted: true

                    onClicked: {
                        myBackEnd.adjustBrightness(0)
                    }
                }
            }
        }

        GridLayout {
            id: innerGrid2

            columns: 2
            rows: 1
            Layout.columnSpan: mainWindow.isPortrait ? 1 : 2
            Layout.topMargin: mainWindow.isPortrait ? 30 : 10
            Layout.alignment: Qt.AlignHCenter
            columnSpacing: mainWindow.isPortrait ? 20 : 40

            Button {
                id: vibrateButton

                highlighted: true
                text: "Vibrate"

                onClicked: {
                    myBackEnd.vibrate()
                }
            }

            Button {
                id: notifyButton

                highlighted: true
                text: "Notify"

                onClicked: {
                    myBackEnd.notify()
                }
            }
        }

        GridLayout {
            id: wakeLockGrid

            columns: 2
            rows: 2
            Layout.columnSpan: mainWindow.isPortrait ? 1 : 2
            Layout.topMargin: mainWindow.isPortrait ? 30 : 10
            Layout.alignment: Qt.AlignLeft
            rowSpacing: 10

            Text {
                id: fullWakeLockText

                text: "Set Full WakeLock"
                font.pointSize: 16
            }

            Switch {
                id: fullWakeLock

                onCheckedChanged: {
                    //! [3]
                    if (checked) {
                        myBackEnd.setFullWakeLock()
                        if (partialWakeLock.checked)
                            partialWakeLock.click()
                        mainWindow.wakeLockStatus = "Full WakeLock active"
                    //! [3]
                    } else {
                        myBackEnd.disableFullWakeLock()
                        if (!partialWakeLock.checked)
                            mainWindow.wakeLockStatus = ""
                    }
                }
            }

            Text {
                id: partialWakeLockText

                text: "Set Partial WakeLock"
                font.pointSize: 16
            }

            Switch {
                id: partialWakeLock

                onCheckedChanged: {
                    if (checked) {
                        myBackEnd.setPartialWakeLock()
                        if (fullWakeLock.checked)
                            fullWakeLock.click()
                        mainWindow.wakeLockStatus = "Partial WakeLock active"
                    } else {
                        myBackEnd.disablePartialWakeLock()
                        if (!fullWakeLock.checked)
                            mainWindow.wakeLockStatus = ""
                    }
                }
            }
        }
    }
}
