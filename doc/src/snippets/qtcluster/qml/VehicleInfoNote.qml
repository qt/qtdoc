/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.2

Item {
    id: infoNote
    height: 70
    width: noteImage.width
    anchors.bottom: car.bottom
    visible: noteVisible && highlightType && !car.hidden
    property int fixedPositionX: 0
    property color textColor: "white"
    property bool noteVisible: false
    property int highlightType: main.carModelHighlightType

    Image {
        id: noteImage
        source: "image://etc/InfoNoteBackground.png"
        opacity: 0.75
    }

    Timer {
        id: waitForCamera
        interval: 800
        running: false
        onTriggered: {
            noteVisible = true
            if (fixedPositionX === 0)
                infoNote.x = car.item.x + (car.item.width - noteImage.width) / 2
            else
                x = fixedPositionX - (noteImage.width / 2)
        }
    }

    onHighlightTypeChanged: {
        if (highlightType)
            waitForCamera.restart()
        else
            noteVisible = false
    }

    Text {
        id: pressureText
        anchors.centerIn: parent
        visible: infoNote.visible && (highlightType >= 0 && highlightType <= 4)
        color: textColor
        font.pixelSize: 16
        font.weight: Font.DemiBold
    }

    Text {
        id: bulbText
        anchors.centerIn: parent
        visible: highlightType >= 5
        text: "Lightbulb"
        color: textColor
        font.pixelSize: 16
        font.weight: Font.DemiBold
    }

    Text {
        id: doorText
        anchors.centerIn: parent
        visible: highlightType === -1
        text: "Check doors"
        color: textColor
        font.pixelSize: 16
        font.weight: Font.DemiBold
    }

    onVisibleChanged: {
        if (visible) {
            infoNote.anchors.horizontalCenterOffset = 0
            if (highlightType === -1) {
                //infoNote.width = doorText.contentWidth + 40
                //infoNote.height = 40
            } else {
                if (highlightType <= 4) {
                    var pressure = Math.random() + 1
                    //var temperature = Math.random() * 12 + 20
                    pressureText.text = pressure.toFixed(1) + " bar"
                    //temperatureText.text = temperature.toFixed(1) + " \u00B0C"

                    //infoNote.width = pressureText.contentWidth + 40
                    //infoNote.height = 40
                } else {
                    switch (highlightType) {
                    case 5:
                        bulbText.text = "Check left headlight"
                        break

                    case 6:
                        bulbText.text = "Check right headlight"
                        break

                    case 7:
                        bulbText.text = "Check right daylight"
                        break

                    case 8:
                        bulbText.text = "Check left daylight"
                        break

                    case 9:
                        infoNote.anchors.verticalCenterOffset = 60
                        bulbText.text = "Check left taillight"
                        break

                    case 10:
                        infoNote.anchors.verticalCenterOffset = 60
                        bulbText.text = "Check right taillight"
                        break

                    default:
                        // Coding fault if we get here, undefined code
                        bulbText.text = "Check lights"
                    }

                    //infoNote.width = bulbText.contentWidth + 40
                    //infoNote.height = 40
                }
            }
        }
    }
}
