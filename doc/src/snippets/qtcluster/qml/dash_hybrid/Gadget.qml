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

Item {
    id: gadget

    width: 240
    height: 240

    property real value: 0
    property real minValue: 0
    property real maxValue: 200

    property real __t: value / (maxValue - minValue)

    property real __scale: __t * 1.04 + (1 - __t) * 0.85 * __scaleAnimation
    property real __scaleAnimation: 1

    property bool green: true


    SequentialAnimation {
        running: true
        loops: -1
        PropertyAnimation {

            target: gadget
            from: 1
            to: 0.95
            property: "__scaleAnimation"
            duration: 600
        }
        PropertyAnimation {
            target: gadget
            from: 0.95
            to: 1
            property: "__scaleAnimation"
            duration: 600
        }
    }

    Item {
        id: glow

        x: 53
        y: 52
        width: 145
        height: 145

        scale: gadget.__scale

        Image {
            id: green
            x: 0
            y: -1

            source: "image://etc/greenglow.png"
            Behavior on opacity {
                NumberAnimation {

                }
            }
        }

        Image {
            id: red
            x: -1
            y: 0

            source: "image://etc/redglow.png"
            Behavior on opacity {
                NumberAnimation {

                }
            }
        }


    }

    Image {
        id: knob
        x: 68
        y: 65
        source: "image://etc/knob.png"
    }
    states: [
        State {
            name: "red"
            when: !gadget.green
        },
        State {
            name: "green"
            when: gadget.green

            PropertyChanges {
                target: red
                opacity: 0
            }
        }
    ]
}
