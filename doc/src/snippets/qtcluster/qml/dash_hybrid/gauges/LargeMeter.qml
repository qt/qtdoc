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

import QtQuick 2.6
import ClusterDemo 1.0
import QtGraphicalEffects 1.0

Item {

    Rectangle {
        visible: false
        width: 86
        height: 86
        radius: 43
        color: "#3a5fe1"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    width: 480
    height: 480

    id: speedometer

    property real speedometerNeedleRotation: 0.0

    property bool animationStopped: ValueSource.runningInDesigner ? true : startupAnimationsFinished

    property real actualValue: 90

    property real minValueAngle: 55
    property real maxValueAngle: 305
    property real minimumValue: 0
    property real maximumValue: 200

    property real limitValue: 100

    property real angleOffset: 35

    property alias fillWidth: speedFiller.fillWidth

    GaugeFiller {
        anchors.fill: parent
        id: speedFiller
        value: speedometer.actualValue
        numVertices: 64
        radius: 155
        fillWidth: 10
        color: speedometer.actualValue < speedometer.limitValue ? "#0098c3" : "#a31e21"
        opacity: 0.4
        minAngle: speedometer.minValueAngle
        maxAngle: speedometer.maxValueAngle
        minValue: speedometer.minimumValue
        maxValue: speedometer.maximumValue

        Behavior on color {
            ColorAnimation {
                duration: 1000
            }
        }
    }


    Item {
        id: speedometerNeedle
        width: needleImage.width
        height: needleImage.height
        rotation: speedFiller.angle - speedometer.angleOffset

        anchors.centerIn: parent

        Item {

            Image {
                x: -59
                y: -0.5
                source: "image://etc/SpeedometerNeedle.png"
                opacity: 1
                layer.enabled: true
                layer.effect: Colorize {
                    hue: 0.5
                }
                Behavior on opacity {
                    NumberAnimation {
                        duration: 1000
                    }
                }
            }
            Image {
                x: -59
                y: -0.5
                id: needleImage
                opacity: speedometer.actualValue < speedometer.limitValue ? 0 : 0.75
                source: "image://etc/SpeedometerNeedle.png"
                Behavior on opacity {
                    NumberAnimation {
                        duration: 1000
                    }
                }
                layer.enabled: true
                layer.effect: Colorize {
                    hue: 0.95
                }
            }

        }
    }

}
