// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Page {
    id: mainPage

    property alias isCurrent: showcaseView.isAnimationRunning

    signal startRequested()

    background: Item { visible: false }

    GridLayout {
        id: portraitGridLayout
        visible: ApplicationConfig.isPortrait
        columns: 1
        width: ApplicationConfig.responsiveSize(1760)

        anchors {
            fill: parent
            top: parent.top
            bottomMargin: ApplicationConfig.responsiveSize(320)
            topMargin: ApplicationConfig.responsiveSize(200)
        }

        LayoutItemProxy {
            target: showcaseView
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth:  ApplicationConfig.responsiveSize(2089)
            Layout.preferredHeight: ApplicationConfig.responsiveSize(1980)
        }

        Item {
            implicitWidth: 2
            Layout.fillHeight: true
        }

        LayoutItemProxy {
            target: chooseButton
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
        }
    }

    GridLayout {
        id: landscapeGridLayout
        columns: 2
        visible: !ApplicationConfig.isPortrait
        anchors {
            fill: parent
            bottomMargin: ApplicationConfig.responsiveSize(320)
            topMargin: ApplicationConfig.responsiveSize(200)
            leftMargin: ApplicationConfig.responsiveSize(320)
            rightMargin: ApplicationConfig.responsiveSize(420)
        }

        LayoutItemProxy {
            target: showcaseView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }

        LayoutItemProxy {
            target: chooseButton
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        }
    }

    ShowcaseView {
        id: showcaseView
    }

    ToyButton {
        id: chooseButton
        textStyle: ApplicationConfig.TextStyle.H2_Bold
        text: qsTr("Tap to Start")
        Layout.preferredWidth: ApplicationConfig.responsiveSize(881)
        Layout.preferredHeight: ApplicationConfig.responsiveSize(288)
        onClicked: mainPage.startRequested()
    }
}
