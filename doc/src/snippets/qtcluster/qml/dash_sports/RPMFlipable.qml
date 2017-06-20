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
import ClusterDemo 1.0

Flipable {
    id: flipable
    height: width
    property bool flipped: false
    signal loaded
    property alias flipRotation: flipRotation
    property alias rpm: rpm

    property int rpmValue: 4000

    front: Loader {
        id: rpm
        width: parent.width
        height: width
        asynchronous: true
        source: "RPMGauge_painter.qml"
        onLoaded: flipable.loaded()
    }

    back: Loader {
        width: parent.width
        height: width
        asynchronous: true
        source: "../CarParkingSports.qml"
    }

    transform: Rotation {
        id: flipRotation
        origin.x: flipable.width / 2
        origin.y: flipable.height / 2
        axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
        angle: 90   // the default angle
    }

    states: [
        State {
            name: "back"
            PropertyChanges {
                target: flipRotation
                angle: 180
            }
            PropertyChanges {
                target: flipable.front
                visible: false
            }

            PropertyChanges {
                target: flipable.back
                visible: true
            }

            when: flipable.flipped
        },
    State {
        name: "front"
        PropertyChanges {
            target: flipRotation
            angle: 0
        }
        PropertyChanges {
            target: flipable.front
            visible: true
        }

        PropertyChanges {
            target: flipable.back
            visible: false
        }
         when: !flipable.flipped
    }
    ]

    transitions: Transition {
        NumberAnimation { target: flipRotation; property: "angle"; duration: 300 }
    }

    //Fill background while flipping. TODO think better way to do it
    Rectangle {
        anchors.centerIn: parent
        radius: flipable.width+4 /2
        width: flipable.width+4
        height: flipable.width+4
        color: "black"
        z: -1
    }
}
