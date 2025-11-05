// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

Item {
    id: toyGalleryPage

    signal toySelected(index: int)

    Item {
        anchors {
            fill: parent
            leftMargin: ApplicationConfig.responsiveSize(200)
            rightMargin: ApplicationConfig.responsiveSize(200)
        }

        GridView {
            id: toyView
            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            width: Math.max(cellWidth, Math.floor(parent.width / cellWidth) * cellWidth)
            clip: true
            cellWidth: Math.floor(ApplicationConfig.responsiveSize(565))
            cellHeight: ApplicationConfig.responsiveSize(900)
            snapMode: GridView.SnapToRow
            model: ToyModel
            delegate: GalleryViewDelegate {
                onToySelected: () => toyGalleryPage.toySelected(index)
            }
        }
    }

    Rectangle {
        id: fadeInView
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        height: ApplicationConfig.responsiveSize(40)
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "#00DAEBFF"
            }
            GradientStop {
                position: 1.0
                color: "#91C9FF"
            }
        }
    }
}
