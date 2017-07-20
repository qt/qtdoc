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

Item {

    id: speedometer

    property real speedometerNeedleRotation: 0.0
    property string speed: actualSpeed.toFixed().toString()

    property bool animationStopped: ValueSource.runningInDesigner ? true : startupAnimationsFinished

    property real actualSpeed: animationStopped
                             ? ValueSource.kph : -speedometerNeedleRotation

    property real minValueAngle: 55
    property real maxValueAngle: 305
    property real minimumSpeed: 0
    property real maximumSpeed: 200

    Item {
        anchors.left: parent.left
        anchors.leftMargin: 20
        width: 480
        height: 480

        GaugeFiller {
            id: speedFiller
            value: speedometer.actualSpeed
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 244
            anchors.leftMargin: 255
            numVertices: 64
            radius: 155
            fillWidth: 5
            color: speedometer.actualSpeed < 100 ? "green" : "#EF2973"
            opacity: 0.6
            minAngle: speedometer.minValueAngle
            maxAngle: speedometer.maxValueAngle
            minValue: speedometer.minimumSpeed
            maxValue: speedometer.maximumSpeed
        }
    }

    Item {
        id: speedometerNeedle
        width: 309
        height: 7
        rotation: speedFiller.angle - 35

        x: 121
        y: 243

        Image {
            opacity: 0.75
            width: 97
            height: 7
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            source: speedometer.actualSpeed < 100 ? "image://etc/SpeedometerNeedleGreen.png" : "image://etc/SpeedometerNeedle.png"
        }
    }

    Row {
        anchors.top: speedometerNeedle.bottom
        anchors.topMargin: 80
        anchors.horizontalCenter: speedometerNeedle.horizontalCenter
        spacing: 7

        Text {
            font.pixelSize: 18
            color:(ValueSource.gear === 0 && ValueSource.parkingBrake) ? "white" : "gray"
            text: "P"
        }

        Text {
            font.pixelSize: 18
            //font.bold: ValueSource.gear === -1
            color: ValueSource.gear === -1 ? "white" : "gray"
            text: "R"
        }

        Text {
            font.pixelSize: 18
            //font.bold: ValueSource.gear === 0
            color: (ValueSource.gear === 0 && !ValueSource.parkingBrake) ? "white" : "gray"
            text: "N"
        }

        Text {
            font.pixelSize: 18
            //font.bold: ValueSource.gear === 1
            color: ValueSource.gear === 1 ? "white" : "gray"
            text: "D"
        }
    }

    Text {
        id: speedText
        anchors.top: speedometerNeedle.top
        anchors.topMargin: -27
        anchors.horizontalCenter: speedometerNeedle.horizontalCenter
        font.pixelSize: 40
        color: "lightGray"
        text: speedometer.speed
    }

    Text {
        id: speedUnitText
        anchors.top: speedText.bottom
        anchors.horizontalCenter: speedometerNeedle.horizontalCenter
        font.pixelSize: 18
        color: "lightGray"
        text: "KM/H"
    }
}
