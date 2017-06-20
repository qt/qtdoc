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

import QtQuick 2.0
import QtLocation 5.5
import QtPositioning 5.5
import QtGraphicalEffects 1.0
import ClusterDemo 1.0

Item {
    width: root.width / 3
    height: width

    Map {
        id: map
        width: parent.width + 300
        height: parent.height + 300
        x: -150
        y: -150
        property real speed

        plugin: Plugin {
            id: plugin
            preferred: ["mapbox"]
            PluginParameter { name: "mapbox.access_token"; value: "pk.eyJ1IjoicXRjbHVzdGVyIiwiYSI6ImZiYTNiM2I0MDE2NmNlYmY0ZmM5NWMzZDVmYzI4NjFlIn0.uk3t7Oi9lDByIJd2E0vRWg" }
            PluginParameter { name: "mapbox.map_id"; value: "qtcluster.ndeb6ce6" }
        }

        center: QtPositioning.coordinate(ValueSource.latitude, ValueSource.longitude)

        zoomLevel: 16

        enabled: false

        rotation: -ValueSource.direction

        Behavior on rotation {
            RotationAnimation {
                duration: 2000
                direction: RotationAnimation.Shortest
            }
        }

// uncomment ifndef QTIVIVEHICLEFUNCTIONS
//        PositionSource {
//            id: positionSource
//            nmeaSource: "qrc:/qml/route.txt"
//            onPositionChanged: {

//                if (position.speedValid) {
//                    // center the map on the current position
//                    if (position.direction > 0) {
//                        map.rotation = -position.direction
//                        map.center = position.coordinate
//                    }

//                    ValueSource.kph = position.speed * 3.6
//                    ValueSource.oldSpeed.shift()
//                    ValueSource.oldSpeed.push(position.speed * 3.6)
//                    ValueSource.speedChanged()
//                    //routeStopped.restart()
//                }
//            }
//        }
//        Component.onCompleted:{
//            positionSource.start()
//            //routeStopped.running = true
//        }
// end comment

        Behavior on center {
            id: centerBehavior
            enabled: true
            CoordinateAnimation { duration: 1500 }
        }
    }

    FastBlur {
        anchors.fill: map
        source: map
        radius: 0.01
        rotation: map.rotation
    }

    Image {
        id: positionImage
        anchors.centerIn: parent
        source: mapPositionImage
    }

    Text {
        color: "white"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: (ValueSource.carId === 0) ? 75 : 0
        font.pixelSize: 9
        text:"© Mapbox © OpenStreetMap"
    }
}
