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

Item {
    id: root
    width: 338
    height: 338

    property real value: 5
    property real scaleFactor: 1.3

    NumberLabel {
        id: text_0
        x: 64
        y: 237
    }

    NumberLabel {
        id: text_20
        x: 39
        y: 184
        text: "20"
    }

    NumberLabel {
        id: text_40
        x: 40
        y: 126
        text: "40"
    }

    NumberLabel {
        id: text_60
        x: 67
        y: 78
        text: "60"
    }

    NumberLabel {
        id: text_80
        x: 112
        y: 45
        text: "80"
    }

    NumberLabel {
        id: text_100
        x: 158
        y: 35
        text: "100"
    }

    NumberLabel {
        id: text_120
        x: 211
        y: 45
        text: "120"
    }

    NumberLabel {
        id: text_140
        x: 250
        y: 78
        text: "140"
    }

    NumberLabel {
        id: text_160
        x: 277
        y: 126
        text: "160"
    }

    NumberLabel {
        id: text_180
        x: 279
        y: 185
        text: "180"
    }

    NumberLabel {
        id: text_200
        x: 256
        y: 237
        text: "200"
    }

    states: [
        State {
            name: "0"

            when: root.value < 10

            PropertyChanges {
                target: text_0
                color: "#0098c3"
                scale: 1.2
            }
        },
        State {
            name: "20"

            when: root.value > 10 && root.value < 30

            PropertyChanges {
                target: text_20
                color: "#0098c3"
                scale: root.scaleFactor
            }
        },
        State {
            name: "40"

            when: root.value > 30 && root.value < 50

            PropertyChanges {
                target: text_40
                color: "#0098c3"
                scale: root.scaleFactor
            }
        },
        State {
            name: "60"

            when: root.value > 50 && root.value < 70

            PropertyChanges {
                target: text_60
                color: "#0098c3"
                scale: root.scaleFactor
            }
        },
        State {
            name: "80"

            when: root.value > 70 && root.value < 90

            PropertyChanges {
                target: text_80
                color: "#0098c3"
                scale: root.scaleFactor
            }
        },
        State {
            name: "100"

            when: root.value > 90 && root.value < 110

            PropertyChanges {
                target: text_100
                color: "#a31e21"
                scale: root.scaleFactor
            }
        },
        State {
            name: "120"

            when: root.value > 110 && root.value < 130

            PropertyChanges {
                target: text_120
                color: "#a31e21"
                scale: root.scaleFactor
            }
        },
        State {
            name: "140"

            when: root.value > 130 && root.value < 150

            PropertyChanges {
                target: text_140
                color: "#a31e21"
                scale: root.scaleFactor
            }
        },
        State {
            name: "160"

            when: root.value > 150 && root.value < 170

            PropertyChanges {
                target: text_160
                color: "#a31e21"
                scale: root.scaleFactor
            }
        },
        State {
            name: "180"

            when: root.value > 170 && root.value < 190

            PropertyChanges {
                target: text_180
                color: "#a31e21"
                scale: root.scaleFactor
            }
        },
        State {
            name: "200"

            when: root.value > 190

            PropertyChanges {
                target: text_200
                color: "#a31e21"
                scale: root.scaleFactor
            }
        }
    ]

    transitions: Transition {
        from: "*"
        to: "*"

        ParallelAnimation {
            NumberAnimation {
                properties: "scale"
                duration: 400
            }

            ColorAnimation {
                properties: "color"
                duration: 400
            }
       }
    }
}
