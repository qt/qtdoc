/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the Qt3D module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or later as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file. Please review the following information to
** ensure the GNU General Public License version 2.0 requirements will be
** met: http://www.gnu.org/licenses/gpl-2.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.2
import QtQuick.Scene3D 2.0
import QtQuick.Window 2.1

Window {
    id: root
    property bool leftView: true
    visible: true
    width: 1280
    height: 480
    color: "Black"
    title: "iCluster"
    property bool toggleCarView: false
    property bool carVisible: true
    property int carModelHighlightType
    property bool actionInProgress
    property bool rightStack

    Timer {
        // Dummy timer, does nothing
        id: returnView
        interval: 1.0
    }

    CarViewSports {
        id: carView
        width: root.width
        height: root.height
        visible: true
        hidden: false
    }

//    CarViewElectric {
//        id: carView
//        width: root.width
//        height: root.height
//        visible: true
//        hidden: false
//    }

    Rectangle {
        id: buttonToggleVisible
        width: 100
        height: 50
        radius: 5
        border.color: "green"
        border.width: 2
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.topMargin: 5
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Visible"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (carVisible == false) {
                    console.log("Show car")
                    carView.hidden = false
                    carVisible = true
                    buttonToggleVisible.border.color = "green"
                } else {
                    console.log("Hide car")
                    carView.hidden = true
                    carVisible = false
                    buttonToggleVisible.border.color = "red"
                }
            }
        }
    }

    Rectangle {
        id: buttonHighlightTire
        width: 100
        height: 50
        radius: 5
        border.color: "green"
        border.width: 2
        anchors.right: parent.right
        anchors.top: buttonToggleVisible.bottom
        anchors.rightMargin: 5
        anchors.topMargin: 5
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Tire"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                carView.highlightTire()
            }
        }
    }

    Rectangle {
        id: buttonHighlightLamp
        width: 100
        height: 50
        radius: 5
        border.color: "green"
        border.width: 2
        anchors.right: parent.right
        anchors.top: buttonHighlightTire.bottom
        anchors.rightMargin: 5
        anchors.topMargin: 5
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Lamp"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                carView.highlightLamp()
            }
        }
    }

    Rectangle {
        id: buttonHighlightDoor
        width: 100
        height: 50
        radius: 5
        border.color: "green"
        border.width: 2
        anchors.right: parent.right
        anchors.top: buttonHighlightLamp.bottom
        anchors.rightMargin: 5
        anchors.topMargin: 5
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Doors"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                carView.highlightDoors(Math.floor(Math.random() * 63) + 1)
            }
        }
    }

//    FpsCounter {
//        visible: true
//        z: 3
//    }
}
