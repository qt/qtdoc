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
import ".."
import "."
import ClusterDemo 1.0
import QtQuick.Extras 1.4

Item {

    id: root

    width: 1280
    height: 480

    property alias camera: camera
    property alias car: car
    property alias speedoMeter: speedoMeter
    property alias flipable: flipable

    property bool startupAnimationStopped: false

    property int gaugeDemoTime: 1000
    property alias centerStack: centerStack // duration (/2) of the gauge needle animation at startup

    property color iconRed: "#e41e25"
    property color iconGreen: "#5caa15"
    property color iconYellow: "#face20"
    property color iconDark: "#444444"

    // TODO: Needed, as background clearing gets messed up after hybrid 3D
    Rectangle {
        anchors.fill: parent
        color: "black"
        z: -1
    }

    Image {
        id: frame
        source: "image://etc/DashboardFrameSport-mask.png"
        z: 2
    }

    //where?
    CameraLoader {
        id: camera

        width: parent.width / 2.5
        height: parent.height - 180

        anchors.centerIn: parent
    }

    // comment ifndef QT_3DCORE_LIB
    CarLoader {
        id: car

        width: parent.width / 2.5
        height: parent.height - 180

        anchors.centerIn: parent
    }
    // end comment
    Item {
        id: container

        width: root.width
        height: root.height
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 0
        anchors.centerIn: parent

        SpeedoMeterLoader {
            id: speedoMeter
            anchors.left: parent.left
            anchors.leftMargin: 48
            anchors.top: parent.top
            anchors.topMargin: 67
            height: width
            value: 33
            width: 380
            z: 4
        }

        CenterStack {
            id: centerStack
            viewIndex: 3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 83
        }

        RPMFlipable {
            id: flipable
            anchors.right: parent.right
            anchors.rightMargin: 50
            anchors.top: parent.top
            anchors.topMargin: 69
            width: 380
            rpmValue: 2212
            flipped: false
            z: 4
        }
    }

    Item {
        width: speedoMeter.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: pilotLights.top

        TurnIndicator {
            anchors.left: parent.left
            direction: Qt.LeftArrow
            active: ValueSource.turnSignal & Qt.LeftArrow
            width: 48
            height: 48
        }

        TurnIndicator {
            anchors.right: parent.right
            direction: Qt.RightArrow
            active: ValueSource.turnSignal & Qt.RightArrow
            width: 48
            height: 48
        }

        z: 3
    }

    Item {
        id: bottomRow
        height: 68
        width: 320
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        z: 3
        property int pixelSize: 17
        Text {
            text: ValueSource.date
            color: "white"
            font.pixelSize: bottomRow.pixelSize
            anchors.right: temperature.left
            anchors.rightMargin: 15
        }
        Text {
            id: temperature
            text: "+18°C"
            color: "white"
            font.pixelSize: bottomRow.pixelSize
            anchors.right: time.left
            anchors.rightMargin: 15
        }
        Text {
            id: time
            text: ValueSource.time
            color: "white"
            font.pixelSize: bottomRow.pixelSize
            anchors.right: parent.right
        }
    }

    Row {
        id: pilotLights
        anchors.horizontalCenter: parent.horizontalCenter
        y: 23
        spacing: 2
        z: 3

        Picture {
            width: 48
            height: 48

            color: ValueSource.lowBeam ? root.iconGreen : root.iconDark
            source: "qrc:/iso-icons/iso_grs_7000_4_0456.dat"
        }

        Picture {
            width: 48
            height: 48

            color: ValueSource.seatBelt ? root.iconRed : root.iconDark
            source: "qrc:/iso-icons/iso_grs_7000_4_0249.dat"
        }


        Picture {
            width: 48
            height: 48

            color: ValueSource.lowBeam ? root.iconRed : root.iconDark
            source: "qrc:/iso-icons/iso_grs_7000_4_0083.dat"
        }

        Picture {
            width: 48
            height: 48

            color: ValueSource.lightFailure ? root.iconYellow : root.iconDark
            source: "qrc:/iso-icons/iso_grs_7000_4_1555.dat"
        }
    }

    VehicleInfoNote {
        anchors.bottom: car.bottom
        visible: noteVisible && highlightType && !car.hidden
        id: alertNote
        textColor: "orange" //"#3a98c4"
        fixedPositionX: centerStack.x + (centerStack.width / 2)
    }

    // end comment
}
