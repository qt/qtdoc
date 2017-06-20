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
import QtQuick.Extras 1.4
import ClusterDemo 1.0
import "../functions.js" as Functions

Item {
    id: rpmItem
    property real rpmValue: flipable.rpmValue
    property alias maxValue: rpmGauge.maxValue

    property color iconRed: "#e41e25"
    property color iconGreen: "#5caa15"
    property color iconYellow: "#face20"
    property color iconDark: "#444444"

    Item {
        id: rpmGauge

        anchors.fill: parent
        width: height
        property bool animated: ValueSource.runningInDesigner ? false : startupAnimationStopped

        property real value: animated ? ValueSource.rpm : rpmValue

        property real maxValue: 8000

        property real maxValueAngle: 90
        property real minValueAngle: -90

        property real outerRadius: Math.min(width, height) * 0.5
        property real needleEndInDegrees: 180 / rpmGauge.maximumValue

        Image {
            source: "image://etc/Gauge_RPM.png"
            anchors.fill: parent
        }

        Text {
            id: gearText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.verticalCenter
            anchors.topMargin: Functions.toPixels(0.12, parent.outerRadius)
            font.pixelSize: Functions.toPixels(0.3, parent.outerRadius)
            color: "white"
            text: ValueSource.gearString
        }

        Picture {
            id: engineLight

            width: 48
            height: 48

            anchors.top: gearText.bottom
            anchors.topMargin: 10
            anchors.left: parent.horizontalCenter

            source: "qrc:/iso-icons/iso_grs_7000_4_0247.dat"
            color: ValueSource.batteryLevel > 15 ? rpmItem.iconDark : rpmItem.iconRed
            z: 3
        }

        Picture {
            id: batteryLight

            width: 48
            height: 48

            anchors.top: gearText.bottom
            anchors.topMargin: 10
            anchors.right: parent.horizontalCenter
            source: "qrc:/iso-icons/iso_grs_7000_4_0246.dat"
            color: ValueSource.engineTemperature > 100 ? rpmItem.iconYellow : rpmItem.iconDark
            z: 3
        }

        CircularIndicator {
            anchors.fill: parent

            startAngle: rpmGauge.minValueAngle
            endAngle: rpmGauge.maxValueAngle
            minimumValue: 0
            maximumValue: rpmGauge.maxValue
            value: rpmGauge.value
            padding: 13
            backgroundColor: "transparent"
            progressColor: "#E31E24"
        }
    }

    CircularIndicator {
        id: batteryGauge
        anchors.fill: parent

        startAngle: 144
        endAngle: 108
        minimumValue: 0
        maximumValue: 100
        value: ValueSource.batteryLevel
        padding: 12
        backgroundColor: "transparent"
        progressColor: "#464749"
    }

    CircularIndicator {
        id: engineTempGauge
        anchors.fill: parent

        endAngle: -108
        startAngle: -145
        minimumValue: 40
        maximumValue: 120
        value: ValueSource.engineTemperature
        padding: 12
        backgroundColor: "transparent"
        progressColor: "#464749"
    }
}

