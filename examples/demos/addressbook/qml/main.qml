// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Qt.labs.qmlmodels

import AddressBookModel

ApplicationWindow {
    id: root
    width: 850
    height: 350
    visible: true
    title: qsTr("Address Book")
    required property AddressBookModel addressBookModel

    Button {
        id: newContactButton
        text: qsTr("Add new contact")
        onClicked: newContactPopup.open()
    }
    Popup {
        id: newContactPopup
        padding: 10
        anchors.centerIn: parent
        modal: true
        focus: true

        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        GridLayout {
            columns: 2
            TextField {
                id: newNameField
                placeholderText: qsTr("Enter name")
                padding: 10
            }
            TextField {
                id: newAddressField
                placeholderText: qsTr("Enter address")
                padding: 10
            }
            Button {
                text: qsTr("Cancel")
                onClicked: {
                    newContactPopup.close();
                }
            }
            Button {
                text: qsTr("Add")
                onClicked: {
                    addressBookModel.addContact(newNameField.displayText,
                        newAddressField.displayText);
                    newContactPopup.close();
                }
            }
        }
    }

    Button {
        id: authorizeButton
        text: qsTr("Authorize")
        onClicked: authorizePopup.open()
        anchors {
            top: newContactButton.bottom
            left: newContactButton.left
        }
    }
    Popup {
        id: authorizePopup
        padding: 10
        anchors.centerIn: parent
        modal: true
        focus: true

        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        GridLayout {
            columns: 2
            TextField {
                id: apiKeyField
                text: "api_key"
                padding: 10
                readOnly: true
            }
            TextField {
                id: apiKeyValueField
                placeholderText: qsTr("Enter API key value")
                padding: 10
            }
            Button {
                text: qsTr("Cancel")
                onClicked: {
                    authorizePopup.close();
                }
            }
            Button {
                text: qsTr("Set")
                onClicked: {
                    addressBookModel.setAuthorizationHeader(apiKeyField.displayText,
                        apiKeyValueField.displayText);
                    authorizePopup.close();
                }
            }
        }
    }

    HorizontalHeaderView {
        id: horizontalHeader
        model: addressBookModel
        syncView: tableView
        anchors {
            top: newContactButton.top
            left: newContactButton.right
        }
    }

    TableView {
        id: tableView
        model: addressBookModel
        anchors {
            top: horizontalHeader.bottom
            left: horizontalHeader.left
        }
        width: 700
        height: 350
        columnSpacing: 1
        rowSpacing: 1
        clip: true
        property var columnWidthsFactor: [0.15, 0.35, 0.5]
        columnWidthProvider: function (column) {
            return tableView.model ? tableView.width * columnWidthsFactor[column] : 0;
        }
        rowHeightProvider: function (row) {
            return 50;
        }

        delegate: DelegateChooser {
            DelegateChoice {
                column: 0
                delegate: Rectangle {
                    SystemPalette { id: activePalette }
                    color: activePalette.alternateBase
                    Button {
                        id: deleteButton
                        text: qsTr("Delete")
                        onClicked: addressBookModel.removeContact(id)
                    }
                }
            }
            DelegateChoice {
                column: 1
                delegate: Rectangle {
                    TextInput {
                        text: name
                        padding: 10
                        onEditingFinished: addressBookModel.updateContact(id, displayText, address)
                    }
                }
            }
            DelegateChoice {
                column: 2
                delegate: Rectangle {
                    TextInput {
                        text: address
                        padding: 10
                        onEditingFinished: addressBookModel.updateContact(id, name, displayText)
                    }
                }
            }
        }
    }
}
