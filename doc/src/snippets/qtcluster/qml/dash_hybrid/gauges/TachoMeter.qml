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
    id: tachometer

    property real tachometerNeedleRotation: 0.0
    property string rpm: actualRPM.toFixed().toString()

    property bool animationStoped: ValueSource.runningInDesigner ? true : startupAnimationsFinished

    property real actualRPM: animationStoped
                             ? ValueSource.rpm : -tachometerNeedleRotation

    property real minValueAngle: 55
    property real maxValueAngle: 255
    property real minimumRPM: 0
    property real maximumRPM: 8000

    Item {
        anchors.right: parent.right
        anchors.rightMargin: 20
        width: 480
        height: 480

        GaugeFiller {
            id: rpmFiller
            value: tachometer.actualRPM
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 246
            anchors.rightMargin: 253
            numVertices: 64
            radius: 155
            fillWidth: 5
            color: tachometer.actualRPM < 4000 ? "green" : "#EF2973"
            opacity: 0.6
            minAngle: tachometer.minValueAngle
            maxAngle: tachometer.maxValueAngle
            minValue: tachometer.minimumRPM
            maxValue: tachometer.maximumRPM
        }
    }

    Item {
        id: tachometerNeedle
        width: 312
        height: 7
        rotation: rpmFiller.angle - 35
        x: 854
        y: 242

        Image {
            opacity: 0.75
            width: 98
            height: 7
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.verticalCenter: parent.verticalCenter
            source: tachometer.actualRPM < 4000 ? "image://etc/SpeedometerNeedleGreen.png" : "image://etc/SpeedometerNeedle.png"
        }
    }

    Text {
        id: textEco
        anchors.top: tachometerNeedle.top
        anchors.topMargin: -7
        anchors.horizontalCenter: tachometerNeedle.horizontalCenter
        text: tachometer.actualRPM > 4000 ? "POWER" : "ECO"
        font.pixelSize: 18
        color: tachometer.actualRPM <= 4000 ? "white" : "red"
    }
}
