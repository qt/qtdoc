/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the documentation of the Qt Toolkit.
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

//QML import statements
import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import QtQuick.Layouts 1.0
import org.qtproject.example 1.0
import QtQuick.Dialogs 1.2

//main window
ApplicationWindow {
    id: applicationWindow1
    visible: true
    width: 640
    height: 480
    title: qsTr(document.documentTitle + " Text Editor Example")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("&Open")
                action: fileOpenAction
            }
            MenuItem {
                text: qsTr("&Save")
                action: fileSaveAction
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }
    toolBar: ToolBar {
        id: toolBar

        RowLayout {
            id: rowToolBar
            spacing: 0.3

            ToolButton {
                id: newToolButton
                anchors.left: parent.left
                iconName: "new_icon"
                iconSource: "images/filenew.png"
                action: newAction
            }

            ToolButton {
                id: openToolButton
                anchors.left: newToolButton.right
                transformOrigin: Item.Center
                iconSource: "images/fileopen.png"
                iconName: "open_icon"
                action: fileOpenAction
            }

            ToolButton {
                id: saveToolButton
                text: qsTr("")
                iconSource: "images/filesave.png"
                iconName: "save_icon"
                isDefault: false
                visible: true
                checkable: false
                anchors.left: openToolButton.right
                action: fileSaveAction
            }

            ToolButton {
                id: cutToolButton
                iconSource: "images/editcut.png"
                iconName: "cut_icon"
                anchors.left: saveToolButton.right
                action: cutAction;
            }

            ToolButton {
                id: copyToolButton
                iconSource: "images/editcopy.png"
                iconName: "copy_icon"
                anchors.left: cutToolButton.right
                action: copyAction
            }

            ToolButton {
                id: pasteToolbutton
                iconSource: "images/editpaste.png"
                iconName: "paste_icon"
                anchors.left: copyToolButton.right
                action: pasteAction
            }
        }
    }

    TextArea {
        id: textArea
        text: document.text
        anchors.fill: parent
    }

    DocumentHandler {
        id: document
    }

    Action {
        id: newAction
        text: "New"
        shortcut: StandardKey.New
        onTriggered: textArea.text = qsTr("")
    }

    Action {
        id: cutAction
        text: "Cut"
        shortcut: StandardKey.Cut
        onTriggered: textArea.cut()
    }

    Action {
        id: copyAction
        text: "Copy"
        shortcut: StandardKey.Copy
        onTriggered: textArea.copy()
    }

    Action {
        id: pasteAction
        text: "Paste"
        shortcut: StandardKey.Paste
        onTriggered: textArea.paste()
    }

    Action {
        id: fileOpenAction
        text: "Open"
        shortcut: StandardKey.Open
        onTriggered: fileOpenDialog.open()
    }

    Action {
        id: fileSaveAction
        text: "Open"
        shortcut: StandardKey.Save
        onTriggered: fileSaveDialog.open()
    }

    FileDialog {
        id: fileOpenDialog
        title: "Please choose a file to open"
        nameFilters: ["Text files (*.txt)"]
        onAccepted: document.fileUrl = fileUrl
    }

    FileDialog {
        id: fileSaveDialog
        title: "Please enter the file to save"
        nameFilters: ["Text files (*.txt)"]
        selectExisting: false
        onAccepted: document.saveFile(fileUrl)
    }

}
