
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
import QtQuick 2.4
import ClusterDemo 1.0

Item {
    id: root
    width: 1280
    height: 480
    property alias gadget2: gadget2

    property alias center: center
    property alias rightGadget: rightGadget
    property alias bar: bar
    property alias leftGadget: leftGadget
    property alias image: image
    property alias rightGauge: rightGauge
    property alias leftGauge: leftGauge
    property alias gadget: gadget

    property real gaugeOpacity: 1

    Image {
        id: image
        source: "image://etc/Cluster8Gauges.png"

        Image {
            id: center
            x: 574
            y: 30
            source: "image://etc/center.png"
        }

        Image {
            id: rightGadget
            x: 732
            y: 34
            source: "image://etc/right.png"
        }

        Image {
            id: leftGadget
            x: 419
            y: 32
            source: "image://etc/left.png"
        }

        Image {
            id: bar
            x: 534
            y: 143
            source: "image://etc/temperature.png"
        }
    }

    Image {
        id: leftGauge
        x: 318
        y: 393
        source: "image://etc/leftgauge.png"

        Gadget {
            id: gadget
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Image {
        id: rightGauge
        x: 652
        y: 394
        source: "image://etc/rightgauge.png"

        Gadget {
            id: gadget2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    states: [
        State {
            name: "start"

            PropertyChanges {
                target: leftGauge
                x: 13
                y: 169
                width: 339
                height: 340
                opacity: 0
                scale: 0.7
            }

            PropertyChanges {
                target: rightGauge
                x: 930
                y: 169
                width: 330
                height: 340
                opacity: 0
                scale: 0.7
            }

            PropertyChanges {
                target: root
                scale: 0.8
                gaugeOpacity: 0
            }

            PropertyChanges {
                target: image
                opacity: 0.2
            }

            PropertyChanges {
                target: gadget
                scale: 0.8
                opacity: 0
            }

            PropertyChanges {
                target: leftGadget
                scale: 0.8
                opacity: 0
            }

            PropertyChanges {
                target: center
                opacity: 0
                scale: 0.8
            }

            PropertyChanges {
                target: rightGadget
                scale: 0.8
                opacity: 0
            }

            PropertyChanges {
                target: bar
                scale: 0.8
                opacity: 0
            }

            PropertyChanges {
                target: gadget2
                opacity: 0
            }
        },
        State {
            name: "normal"

            PropertyChanges {
                target: leftGauge
                x: 102
                y: 75
            }

            PropertyChanges {
                target: rightGauge
                x: 841
                y: 74
            }
        }
    ]
}
