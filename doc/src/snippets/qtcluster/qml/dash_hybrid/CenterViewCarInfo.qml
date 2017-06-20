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
import ClusterDemo 1.0

Item {
    id: carinfoContainer

    property int total: ValueSource.totalDistance
    property int sinceLast: ValueSource.kmSinceCharge
    opacity: 0.5
    property alias xTarget: startupAnimation.to
    property int defaultXPos: 900

    Image {
        id: image
        source: "image://etc/CarInfoIcon.png"
    }

    Row {
        scale: 0.75
        spacing: 7
        anchors.top: image.bottom
        anchors.horizontalCenter: image.horizontalCenter

        CarInfoField {
            title: "Total distance"
            value: carinfoContainer.total.toString()
            unit: "km"
        }

        CarInfoField {
            title: "Since last\ncharge"
            value: carinfoContainer.sinceLast.toString()
            unit: "km"
        }
    }

    Timer {
        id: fadeOutTimer
        interval: 5000
        running: false
        repeat: false
        onTriggered: {
            carinfoContainer.opacity = 0.5
        }
    }

    Behavior on opacity { PropertyAnimation { duration: 500 } }

    PropertyAnimation on x {
        id: startupAnimation
        duration: 500
        easing.type: Easing.InCubic
        onStopped: {
            carinfoContainer.opacity = 1.0
            fadeOutTimer.start()
        }
    }

    onVisibleChanged: {
        if (visible) {
            x = defaultXPos
            startupAnimation.start()
        }
    }
}

