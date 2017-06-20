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
    property real temperatureValue: ValueSource.engineTemperature
    property real minValueAngle: 42.5
    property real maxValueAngle: -42.5
    property real minimumValue: 40
    property real maximumValue: 120

    anchors.right: parent.right
    anchors.top: parent.top
    anchors.rightMargin: 643
    anchors.topMargin: 60

    GaugeFiller {
        id: temperatureFiller
        value: temperatureValue
        anchors.fill: parent
        numVertices: 32
        radius: 140
        fillWidth: 25
        color: "#EF2973"
        opacity: 0.3
        minAngle: minValueAngle
        maxAngle: maxValueAngle
        minValue: minimumValue
        maxValue: maximumValue
        Behavior on value {
            enabled: !ValueSource.automaticDemoMode && startupAnimationsFinished
            PropertyAnimation { duration: 250 }
        }
    }

    Item {
        width: 280
        height: 7
        rotation: temperatureFiller.angle - 47.5
        anchors.centerIn: parent

        Image {
            width: 25
            height: 3
            //opacity: 0.75
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            source: "image://etc/SpeedometerNeedle.png"
        }
    }
}
