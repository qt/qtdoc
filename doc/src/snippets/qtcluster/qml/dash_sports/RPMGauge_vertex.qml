/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the documentation of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
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

import QtQuick 2.0

import "../functions.js" as Functions
import ClusterDemo 1.0

Item {
    id: root

    property bool updateGeometry: false
    property bool showWire: false

    property alias rpmValue: rpmGauge.rpmValue
    property alias maxValue: rpmGauge.maxValue


    Image {
        id: bg
        source: "image://etc/Gauge_RPM.png"

        GaugeFiller {
            id: rpmGauge
            property real outerRadius: Math.min(width, height) * 0.5

            anchors.fill: parent
            radius: 177
            fillWidth: 10

            property real rpmValue: 0
            value: startupAnimationStopped ? ValueSource.rpm : rpmValue

            minAngle: 90
            maxAngle: 270
            maxValue: 8000

            updateGeometry: root.updateGeometry
            doNotFill: root.showWire

//            Behavior on value {
//                enabled: startupAnimationStopped
//                PropertyAnimation { duration: 50 }
//            }
        }

        GaugeFiller {
            // Battery
            anchors.fill: parent
            radius: 177
            fillWidth: 10

            numVertices: 16
            minAngle: 324
            maxAngle: 288
            maxValue: 100
            value: ValueSource.batteryLevel
            color: "#464749"
            updateGeometry: root.updateGeometry
            doNotFill: root.showWire

            Behavior on value {
                enabled: startupAnimationStopped
                PropertyAnimation { duration: 100 }
            }
        }

        GaugeFiller {
            // Engine temp
            anchors.fill: parent
            radius: 177
            fillWidth: 10

            numVertices: 16

            minAngle: 35
            maxAngle: 72
            minValue: 40
            maxValue: 120

            value: ValueSource.engineTemperature > 0 ? ValueSource.engineTemperature : minValue

            color: "#464749"

            updateGeometry: root.updateGeometry
            doNotFill: root.showWire

            Behavior on value {
                enabled: startupAnimationStopped
                PropertyAnimation { duration: 100 }
            }
        }
    }

    Text {
        id: topText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        font.pixelSize: Functions.toPixels(0.3, rpmGauge.outerRadius)
        color: "white"
        text: ValueSource.gearString
    }

    Image {
        id: engineLight
        anchors.top: topText.bottom
        anchors.topMargin: 10
        anchors.left: parent.horizontalCenter
        source: ValueSource.batteryLevel > 15 ? "image://etc/Icon_Battery_OFF.png"
                                              : "image://etc/Icon_Battery_ON.png"
        z: 3
    }

    Image {
        id: batteryLight
        anchors.top: topText.bottom
        anchors.topMargin: 10
        anchors.right: parent.horizontalCenter
        source: ValueSource.engineTemperature > 100 ? "image://etc/Icon_Coolant_ON.png"
                                                    : "image://etc/Icon_Coolant_OFF.png"
        z: 3
    }
}
