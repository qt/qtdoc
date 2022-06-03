// Copyright (C) 2016 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import "PhotoViewerCore"

ApplicationWindow {
    id: mainWindow

    visible: true

    Rectangle {
        focus: true

        Keys.onBackPressed: {
            event.accepted = true
            backButton.clicked()
        }
    }

    property real downloadProgress: 0
    property bool imageLoading: false
    property bool editMode: false

    width: 800; height: 480; color: "#d5d6d8"

    ListModel {
        id: photosModel
        ListElement { tag: "Flowers" }
        ListElement { tag: "Wildlife" }
        ListElement { tag: "Prague" }
    }

    DelegateModel { id: albumVisualModel; model: photosModel; delegate: AlbumDelegate {} }

    GridView {
        id: albumView; width: parent.width; height: parent.height; cellWidth: 210; cellHeight: 220
        model: albumVisualModel.parts.album; visible: albumsShade.opacity != 1.0
    }

    Column {
        spacing: 20; anchors { bottom: parent.bottom; right: parent.right; rightMargin: 20; bottomMargin: 20 }
        Button {
            id: newButton; label: qsTr("Add"); rotation: 3
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                mainWindow.editMode = false
                photosModel.append( { tag: "" } )
                albumView.positionViewAtIndex(albumView.count - 1, GridView.Contain)
            }
        }
        Button {
            id: deleteButton; label: qsTr("Edit"); rotation: -2;
            onClicked: mainWindow.editMode = !mainWindow.editMode
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Button {
            id: quitButton; label: qsTr("Quit"); rotation: -2;
            onClicked: Qt.quit()
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle {
        id: albumsShade; color: mainWindow.color
        width: parent.width; height: parent.height; opacity: 0.0
    }

    ListView { anchors.fill: parent; model: albumVisualModel.parts.browser; interactive: false }

    Button {
        id: backButton
        label: qsTr("Back")
        rotation: 3
        x: parent.width - backButton.width - 6
        y: -backButton.height - 8
        visible: Qt.platform.os !== "android"
    }

    Rectangle { id: photosShade; color: 'black'; width: parent.width; height: parent.height; opacity: 0; visible: opacity != 0.0 }

    ListView { anchors.fill: parent; model: albumVisualModel.parts.fullscreen; interactive: false }

    Item { id: foreground; anchors.fill: parent }

    ProgressBar {
        progress: mainWindow.downloadProgress; width: parent.width; height: 4
        anchors.bottom: parent.bottom; opacity: mainWindow.imageLoading; visible: opacity != 0.0
    }
}
