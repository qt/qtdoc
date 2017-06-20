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
import QtQuick.Layouts 1.1

import ClusterDemo 1.0

Item{
    id: consumptionView
    anchors.fill: parent

    ListView {
        id: listView

        height: 260
        width: 260
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: (ValueSource.carId === 0) ? parent.width / 6 : parent.width / 4.5

        header: Item {
            width: listView.width
            height: 30
            Text {
                anchors.fill: parent
                text: "Consumption past 100 km"
                horizontalAlignment: Text.AlignRight
                color: "white"
                font.pixelSize: 15
            }
        }

        model: 13//contactModel
        delegate: Row {
            spacing: 15
            Text {
                id: levelText
                horizontalAlignment: Text.AlignRight
                y: -levelText.height / 2
                width: 60
                text: {
                    if (index === 0)
                        levelText.text = "900"
                    else if (index === 9)
                        levelText.text = "0"
                    else if (index === 12)
                        levelText.text = "-300"
                    else
                        levelText.text=""
                }
                color: "#717273"
                font.pixelSize: 12
            }
            Rectangle {
                id: levelLine
                visible: index != 6 ? true : false
                color: index === 8 ? "#717273" : "#26282a";
                width: index === 8 ? listView.width / 1.5 : listView.width / 1.6;
                height: 1
            }
            Row {
                visible: index === 6 ? true : false
                spacing: 4
                Repeater {
                    model: 22
                    Rectangle {
                        id: avgLine
                        color: "#717273"
                        width: 4
                        height: 1
                    }
                }
            }
            Text {
                id: avgTExt
                y: -avgTExt.height / 4
                text:{
                    if (index === 5)
                        avgTExt.text = "    Avg"
                    else if (index === 6)
                        avgTExt.text = "300"
                    else if (index === 8)
                        avgTExt.text = "IDEAL"
                    else
                        avgTExt.text=""
                }
                color: "#717273"
                font.pixelSize: 12
            }
        }
    }

    Repeater {
        id: repeater
        property real listHeaderHeight: listView.headerItem.height
        property real listContentItemHeight: listView.contentItem.height
        property int listCount: listView.count
        property real spaceInPixels: listContentItemHeight / listCount
        model: 33
        Rectangle {
            id: valueRect
            color: {
                if (ValueSource.consumption[index] >= 100 )
                    "white"
                else {
                    color = (ValueSource.carId === 0) ? "blue" : "#E31E24"
                }
            }
            width: 2
            height: {
                var levelCount = ValueSource.consumption[index] / 100
                if (ValueSource.consumption[index] >= 100 ) {
                    repeater.height = repeater.spaceInPixels * levelCount
                            - repeater.spaceInPixels - 2 * levelCount //2 is line width
                }
                else {
                    repeater.height = Math.abs(repeater.spaceInPixels * levelCount
                                               - 2 * levelCount)//2 is line width)
                }
            }
            x: listView.x + 75 + index * 5
            y:{
                if (ValueSource.consumption[index] >= 100 ) {
                    repeater.y = (listView.y + repeater.listHeaderHeight
                                  + repeater.spaceInPixels * 7) - height
                }
                else {
                    repeater.y = listView.y + repeater.listHeaderHeight
                            + repeater.spaceInPixels * 7
                }
            }
        }

    }
}



