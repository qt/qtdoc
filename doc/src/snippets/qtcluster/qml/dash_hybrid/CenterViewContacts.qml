/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:GPL-QTAS$
** Commercial License Usage
** Licensees holding valid commercial Qt Automotive Suite licenses may use
** this file in accordance with the commercial license agreement provided
** with the Software or, alternatively, in accordance with the terms
** contained in a written agreement between you and The Qt Company.  For
** licensing terms and conditions see https://www.qt.io/terms-conditions.
** For further information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
** SPDX-License-Identifier: GPL-3.0
**
****************************************************************************/

import QtQuick 2.6

Item {
    id: contactContainer
    opacity: 0.5
    property int defaultYPos: 50
    property alias icon: contactImage.source
    property alias name: contactName.text
    property alias yTarget: startupAnimation.to

    Image {
        id: contactImage
        source: "image://etc/contacts.png"
    }

    Text {
        id: title
        anchors.top: contactImage.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: contactImage.horizontalCenter
        text: contactContainer.name === "" ? "Browsing\ncontacts" : "Calling"
        color: "gray"
        font.pixelSize: 20
    }

    Text {
        id: contactName
        anchors.top: title.bottom
        anchors.horizontalCenter: contactImage.horizontalCenter
        color: "lightGray"
        font.pixelSize: 24
    }

    Timer {
        id: fadeOutTimer
        interval: 5000
        running: false
        repeat: false
        onTriggered: {
            fadeOut.start()
        }
    }

    PropertyAnimation on opacity {
        id: fadeIn
        to: 1.0
        duration: 500
        onStopped: {
            call.start()
        }
    }

    PropertyAnimation on opacity {
        id: fadeOut
        to: 0.5
        duration: 500
    }

    PropertyAnimation on y {
        id: startupAnimation
        duration: 500
        easing.type: Easing.InCubic
        onStopped: {
            fadeIn.start()
            fadeOutTimer.start()
        }
    }

    Timer {
        id: call
        interval: 2000
        running: false
        onTriggered: {
            name = "Jane"
            icon = "image://etc/jane.png"
        }
    }

    onVisibleChanged: {
        if (visible) {
            name = ""
            icon = "image://etc/contacts.png"
            y = defaultYPos
            startupAnimation.start()
        }
    }
}

