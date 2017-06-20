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
    property alias speedValue: speedgauge.speedValue
    property alias maxValue: speedgauge.maxValue

    property bool updateGeometry: false
    property bool showWire: false

    Image {
        id: bg
        anchors.centerIn: parent
        source: "image://etc/Gauge_Speed.png"

        GaugeFiller {
            id: speedgauge

            property real outerRadius: Math.min(width, height) * 0.5

            property real speedValue: 0
            value: startupAnimationStopped ? ValueSource.kph : speedValue

            anchors.fill: parent
            radius: 177
            fillWidth: 10
            updateGeometry: root.updateGeometry
            doNotFill: root.showWire

            Behavior on value {
                enabled: startupAnimationStopped
                PropertyAnimation { duration: 500 }
            }
        }

        GaugeFiller {
            id: fuel
            anchors.fill: parent
            radius: 177
            fillWidth: 10

            value: ValueSource.fuelLevel
            numVertices: 16
            minAngle: 323.7
            maxAngle: 287.7
            maxValue: 100

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
        font.pixelSize: Functions.toPixels(0.3, speedgauge.outerRadius)
        color: "white"
        text: speedgauge.value.toFixed()
    }

    Text {
        id: kmText
        text: "km/h"
        color: "white"
        font.pixelSize: Functions.toPixels(0.09, speedgauge.outerRadius)
        anchors.top: topText.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Image {
        id: tyreLight
        anchors.right: parkingLight.left
        anchors.bottom: parkingLight.bottom
        anchors.bottomMargin: 18
        source: ValueSource.flatTire ? "image://etc/Icon_TyreMalfunction_ON.png"
                                     : "image://etc/Icon_TyreMalfunction_OFF.png"
    }

    Image {
        id: parkingLight
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: kmText.bottom
        anchors.topMargin: 20

        source: ValueSource.parkingBrake ? "image://etc/Icon_ParkingBrake_ON.png"
                                         : "image://etc/Icon_ParkingBrake_OFF.png"
    }

    Image {
        id: fuelLight
        anchors.left: parkingLight.right
        anchors.bottom: parkingLight.bottom
        anchors.bottomMargin: 18
        source: (ValueSource.fuelLevel <= 15) ? "image://etc/Icon_Fuel_ON.png"
                                              : "image://etc/Icon_Fuel_OFF.png"
    }

}
