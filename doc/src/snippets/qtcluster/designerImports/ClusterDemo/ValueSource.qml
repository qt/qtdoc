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

pragma Singleton
import QtQuick 2.6

Item {
    id: valueSource

    property real kph: 30
    property real consumeKW: 0
    property real maxConsumeKWValue: 90
    property real maxChargeKWValue: 40
    property real chargeKW: 10
    property real maxRange: 600
    property real range: (batteryLevel / 100) * maxRange

    property bool runningInDesigner: true

    property var consumption: [300, 600, 700, 800, 900, 700, 600, 300, 50, 50, -100, 50, -100, -150,
        -200, 50, 150, 200, 300, 200, 300, 200, 500, 50, -100, -100, -150, -80, 50, 300, 600, 700, 800,
        600,  700, 300, 50, 50]

    property var turnSignal
    property var currentDate: new Date()
    //property string date: currentDate.toLocaleDateString(Qt.locale("fi_FI"), "ddd d. MMM")
    //property string time: currentDate.toLocaleTimeString(Qt.locale("fi_FI"), "hh:mm")
    property string date: currentDate.toLocaleDateString(Qt.locale("en_GB"))
    property string time: currentDate.toLocaleTimeString(Qt.locale("en_GB"), "hh:mm")

    property real latitude: 0
    property real longitude: 0
    property real direction: 0
    property bool lowBeam: false
    property int carId: 4
    property bool lightFailure: true
    property bool flatTire: false

    property bool frontLeftOpen: false
    property bool frontRightOpen: true
    property bool rearLeftDoorOpen: false
    property bool rearRighDoorOpen: true
    property bool hoodOpen: false
    property bool trunkOpen: true

    property double batteryLevel: 45
    property double fuelLevel: 55
    property int gear: -1
    property bool parkingBrake: true
    // TODO: These two are hacks. View change messages might not come through CAN.
    property bool viewChange: false
    property bool rightViewChange: false
    property string gearString: "1"

    property int rpm: 1450
    property double engineTemperature: 40

    property int totalDistance: 42300
    property int kmSinceCharge: 8
    property int avRangePerCharge: 425
    property int energyPerKm: 324

    property real totalDistanceSince: 10
}
