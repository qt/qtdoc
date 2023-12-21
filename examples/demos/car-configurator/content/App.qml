// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick.Window
import CarRendering

Window {
    id: rootWindow

    width: Constants.width
    height: Constants.height

    visibility: Qt.platform.os === 'android' ? Window.FullScreen : Window.AutomaticVisibility

    visible: true
    title: "CarRendering"

    property url downloadBase

    function downloadProgress(progress: double) {
        progressBar.value = progress
    }

    function downloadStart(num: int) {
        progressText.text = qsTr("Downloading asset %1 of %2").arg(num).arg(AssetDownloader.downloadCount)
    }

    function downloadComplete() {
        messageText.text = qsTr("Initializing...")
        progressText.text = ""
        progressBar.visible = false
        downloadBase = AssetDownloader.downloadUrl
        loader.sourceComponent = mainComponent
    }

    Connections {
        target: AssetDownloader
        function onDownloadStarted(num: int) { rootWindow.downloadStart(num) }
        function onDownloadProgressChanged(progress: double) { rootWindow.downloadProgress(progress) }
        function onFinished() { rootWindow.downloadComplete() }
    }

    Rectangle {
        id: mainScreen

        color: "black"
        anchors.fill: parent

        property bool ready: false

        Loader {
            id: loader

            anchors.fill: parent
            Component.onCompleted: AssetDownloader.start()
        }

        Component {
            id: mainComponent

            ScreenPrimary {
                onAssetPreLoadCompleteChanged: {
                    mainScreen.ready = assetPreLoadComplete
                }
            }
        }
    }

    Rectangle {
        id: splashScreen

        color: "black"
        anchors.fill: parent
        visible: !mainScreen.ready

        Behavior on opacity { PropertyAnimation { duration: Constants.animationDuration } }

        Image {
            id: builtWithQtLogo

            source: "images/builtWithQt.png"
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height * .3
        }

        Text {
            id: messageText

            color: "white"
            text: qsTr("Downloading Assets...")
            font.pixelSize: 30
            font.styleName: "Bold"

            anchors.top: builtWithQtLogo.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: progressText

            color: "white"
            font.pixelSize: 16

            anchors.top: messageText.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }

        ProgressBar {
            id: progressBar

            width: progressText.width
            height: 10

            anchors.top: progressText.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
