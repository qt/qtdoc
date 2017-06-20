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
import ".."
import QtQuick.Extras 1.4

Item {
    id: bottomPanel
    property int iconMargin: 7
    property color iconRed: "#e41e25"
    property color iconGreen: "#5caa15"
    property color iconYellow: "#face20"
    property color iconDark: "#000000"

    anchors.horizontalCenter: parent.horizontalCenter
    width: bottomPanelImage.width
    height: bottomPanelImage.height

    Image {
        id: bottomPanelImage
        source: "image://etc/BottomPanel.png"
    }

    TurnIndicator {
        iconOn: "image://etc/Icon_TurnLeft_ON_small.png"
        iconOff: "image://etc/Icon_TurnLeft_OFF_small.png"
        direction: Qt.LeftArrow
        anchors.verticalCenter: textTime.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 180
        active: ValueSource.turnSignal & Qt.LeftArrow
    }

    Picture {
        id: iconCoolant

        width: 30
        height: 30
        anchors.verticalCenter: textTime.verticalCenter
        anchors.right: iconBattery.left

        color: ValueSource.engineTemperature >= 100.0 ? bottomPanel.iconRed : bottomPanel.iconDark
        source: "qrc:/iso-icons/iso_grs_7000_4_0246.dat"
    }

    SafeRendererPicture {
        id: iconBattery

        width: 30
        height: 30
        anchors.verticalCenter: textTime.verticalCenter
        anchors.right: iconFuel.left

        color: ValueSource.batteryLevel <= 25.0 ? bottomPanel.iconRed : bottomPanel.iconDark
        source: "qrc:/iso-icons/iso_grs_7000_4_0247.dat"
    }

    SafeRendererPicture {
        id: iconFuel

        width: 30
        height: 30
        anchors.verticalCenter: textTime.verticalCenter
        anchors.right: iconParkingBrake.left

        color: ValueSource.fuelLevel <= 20.0 ? bottomPanel.iconRed : bottomPanel.iconDark
        source: "qrc:/iso-icons/iso_grs_7000_4_0245.dat"
    }

    SafeRendererPicture {
        id: iconParkingBrake

        width: 30
        height: 30
        anchors.verticalCenter: textTime.verticalCenter
        anchors.right: textTime.left
        anchors.rightMargin: 3

        color: ValueSource.parkingBrake ? bottomPanel.iconRed : bottomPanel.iconDark
        source: "qrc:/iso-icons/iso_grs_7000_4_0238.dat"
    }

    Text {
        id: textTime
        text: ValueSource.time
        font.pixelSize: 18
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 35
    }

    Picture {
        id: iconLowbeam

        width: 30
        height: 30
        anchors.verticalCenter: textTime.verticalCenter
        anchors.left: textTime.right
        anchors.leftMargin: bottomPanel.iconMargin

        color: ValueSource.lowBeam ? bottomPanel.iconGreen : bottomPanel.iconDark
        source: "qrc:/iso-icons/iso_grs_7000_4_0456.dat"
    }

    Picture {
        id: iconTyre

        width: 30
        height: 30
        anchors.verticalCenter: textTime.verticalCenter
        anchors.left: iconLowbeam.right
        anchors.leftMargin: 2

        color: ValueSource.flatTire ? bottomPanel.iconYellow : bottomPanel.iconDark
        source: "qrc:/iso-icons/iso_grs_7000_4_1434A.dat"
    }

    SafeRendererPicture {
        id: iconLamp

        width: 30
        height: 30
        anchors.verticalCenter: textTime.verticalCenter
        anchors.left: iconTyre.right

        color: ValueSource.lightFailure ? bottomPanel.iconYellow : bottomPanel.iconDark
        source: "qrc:/iso-icons/iso_grs_7000_4_1555.dat"
    }

    SafeRendererPicture {
        id: iconSeatbelt

        width: 30
        height: 30
        anchors.verticalCenter: textTime.verticalCenter
        anchors.left: iconLamp.right

        color: ValueSource.seatBelt ? bottomPanel.iconRed : bottomPanel.iconDark
        source: "qrc:/iso-icons/iso_grs_7000_4_0249.dat"
    }

    TurnIndicator {
        direction: Qt.RightArrow
        iconOn: "image://etc/Icon_TurnLeft_ON_small.png"
        iconOff: "image://etc/Icon_TurnLeft_OFF_small.png"
        anchors.verticalCenter: textTime.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 180
        active: ValueSource.turnSignal & Qt.RightArrow
    }
}
