// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import ColorPalette

ApplicationWindow {
    id: window
    width: 480
    height: 400
    visible: true
    title: qsTr("Color Palette Client")

    enum DataView {
        UserView = 0,
        ColorView = 1
    }

    // When the application starts, prompt the user to select the server URL
    Component.onCompleted: urlSelectionPopup.open()

    //! [RestService QML element]
    RestService {
        id: paletteService

        PaginatedResource {
            id: users
            path: "/api/users"
        }

        PaginatedResource {
            id: colors
            path: "/api/unknown"
        }

        BasicLogin {
            id: loginService
            loginPath: "/api/login"
            logoutPath: "/api/logout"
        }
    }
    //! [RestService QML element]

    Popup {
        // A popup for selecting the server URL
        id: urlSelectionPopup
        anchors.centerIn: parent
        padding: 10
        modal: true
        focus: true
        closePolicy: Popup.NoAutoClose

        Connections {
            target: colors
            // Closes the URL selection popup once we have received data successfully
            function onDataUpdated() {
                fetchTester.stop()
                urlSelectionPopup.close()
            }
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 5

            Label {
                text: qsTr("Select server URL")
                Layout.alignment: Qt.AlignHCenter
            }
            GridLayout {
                id: urlSelectionLayout
                columns: 2
                columnSpacing: 5
                rowSpacing: 5
                enabled: !fetchTester.running

                TextArea {
                    id: url1TextArea
                    // The default URL of the QtHttpServer colorpaletteserver example
                    text: "http://127.0.0.1:49425"
                }
                Button {
                    text: qsTr("Use")

                    onClicked: fetchTester.test(url1TextArea.text)
                }
                Label {
                    id: url2Label
                    // Well-known REST API test service
                    text: "https://reqres.in"
                    leftPadding: url1TextArea.leftPadding
                }
                Button {
                    enabled: paletteService.network.sslSupported
                    text: paletteService.network.sslSupported ? qsTr("Use") : qsTr("No SSL")

                    onClicked: fetchTester.test(url2Label.text)
                }
            }

            Timer {
                id: fetchTester
                interval: 2000

                function test(url) {
                    paletteService.url = url
                    colors.refreshCurrentPage()
                    users.refreshCurrentPage()
                    start()
                }
            }

            RowLayout {
                id: fetchIndicator
                visible: fetchTester.running
                Layout.fillWidth: true

                Label {
                    text: qsTr("Testing URL")
                }
                BusyIndicator {
                    running: visible
                    Layout.fillWidth: true
                }
            }
        }
    }

    Popup {
        // Popup for adding or updating a color
        id: colorPopup
        padding: 10
        modal: true
        focus: true
        anchors.centerIn: parent
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        property bool newColor: true
        property int colorId: -1

        function createNewColor() {
            newColor = true
            colorNameField.text = "cute green"
            colorRGBField.text = "#41cd52"
            colorPantoneField.text = "PMS 802C"
            open()
        }

        function updateColor(data) {
            newColor = false
            colorNameField.text = data.name
            colorRGBField.text = data.color
            colorPantoneField.text = data.pantone_value
            colorId = data.id
            open()
        }

        ColumnLayout {
            anchors.fill: parent

            Label {
                visible: !loginService.loggedIn
                text: qsTr("Login to make any changes")
                Layout.alignment: Qt.AlignVCenter
            }
            GridLayout {
                columns: 3

                Label {
                    text: qsTr("Color name")
                }
                Label {
                    text: qsTr("RGB value")
                }
                Label {
                    text: qsTr("Pantone value")
                }

                TextField {
                    id: colorNameField
                    padding: 10
                }
                TextField {
                    id: colorRGBField
                    padding: 10
                }
                TextField {
                    id: colorPantoneField
                    padding: 10
                }
            }

            Rectangle {
                color: colorRGBField.text
                Layout.fillWidth: true
                Layout.preferredHeight: 30
            }

            RowLayout {
                Layout.fillWidth: true

                Button {
                    text: qsTr("Cancel")
                    onClicked: colorPopup.close()
                }
                Item { Layout.fillWidth: true /* spacer */ }
                Button {
                    enabled: loginService.loggedIn
                    icon.name: "file_upload"
                    text: colorPopup.newColor ? qsTr("Add") : qsTr("Update")

                    onClicked: {
                        if (colorPopup.newColor) {
                            colors.add({"name" : colorNameField.text,
                                        "color" : colorRGBField.text,
                                        "pantone_value" : colorPantoneField.text})
                        } else {
                            colors.update({"name" : colorNameField.text,
                                           "color" : colorRGBField.text,
                                           "pantone_value" : colorPantoneField.text},
                                           colorPopup.colorId)
                        }
                        colorPopup.close()
                    }
                }
            }
        }
    }

    ColumnLayout {
        // The main application layout
        anchors.fill :parent

        ToolBar {
            // Main toolbar
            Layout.fillWidth: true

            RowLayout {
                anchors.fill: parent
                ToolButton {
                    text: qsTr("Users")
                    font.bold: dataView.currentIndex === MainWindow.UserView

                    onClicked: dataView.currentIndex = MainWindow.UserView
                }
                ToolButton {
                    text: qsTr("Colors")
                    font.bold: dataView.currentIndex === MainWindow.ColorView

                    onClicked: dataView.currentIndex = MainWindow.ColorView
                }
                Item { Layout.fillWidth: true /* spacer */ }

                ToolButton {
                    visible: dataView.currentIndex === MainWindow.ColorView
                    icon.name: loginService.loggedIn
                                 ? "logout" : "login"

                    onClicked: {
                        if (loginService.loggedIn)
                            loginService.logout()
                        else
                            dataView.currentIndex = MainWindow.UserView
                    }
                }
                ToolButton {
                    visible: dataView.currentIndex === MainWindow.ColorView
                    icon.name: "add"

                    onClicked: colorPopup.createNewColor()
                }
                ToolButton {
                    icon.name: "refresh"

                    onClicked: {
                        if (dataView.currentIndex === MainWindow.ColorView)
                            colors.refreshCurrentPage()
                        else
                            users.refreshCurrentPage()
                    }
                }
            }
        }

        SwipeView {
            id: dataView

            // Controls which view to show
            currentIndex: MainWindow.UserView

            // The area for the actual user and color data views
            Layout.fillWidth: true
            Layout.fillHeight: true

            Pane {
                // The user data
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    anchors.fill: parent

                    ListView {
                        model: users.data
                        spacing: 5
                        footerPositioning: ListView.OverlayFooter

                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        delegate: RowLayout {
                            id: userInfo

                            required property var modelData
                            readonly property bool logged: (modelData.email === loginService.user)

                            Image {
                                source: userInfo.modelData.avatar

                                Layout.preferredHeight: 30
                                Layout.preferredWidth: 30
                            }
                            ToolButton {
                                icon.name: userInfo.logged
                                             ? "logout" : "login"
                                enabled: userInfo.logged || !loginService.loggedIn

                                onClicked: {
                                    if (userInfo.logged) {
                                        loginService.logout()
                                    } else {
                                        //! [Login]
                                        loginService.login({"email" : userInfo.modelData.email,
                                                            "password" : "apassword",
                                                            "id" : userInfo.modelData.id})
                                        //! [Login]
                                    }
                                }
                            }
                            Label {
                                text: userInfo.modelData.email
                                font.bold: userInfo.logged
                            }
                        }
                        footer: ToolBar {
                            // Paginate buttons if more than one page
                            visible: users.pages > 1
                            implicitWidth: parent.width

                            RowLayout {
                                anchors.fill: parent

                                Item { Layout.fillWidth: true /* spacer */ }
                                Repeater {
                                    model: users.pages

                                    ToolButton {
                                        text: qsTr("Page") + " " + page
                                        font.bold: users.page === page

                                        required property int index
                                        readonly property int page: (index + 1)

                                        onClicked: users.page = page
                                    }
                                }
                                Item { Layout.fillWidth: true /* spacer */ }
                            }
                        }
                    }
                }
            }

            Pane {
                // The color data
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    anchors.fill: parent

                    //! [View and model]
                    ListView {
                        model: colors.data
                    //! [View and model]
                        footerPositioning: ListView.OverlayFooter
                        spacing: 1

                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        delegate: RowLayout {
                            id: colorInfo

                            required property var modelData

                            Rectangle {
                                implicitWidth: 50
                                implicitHeight: 20
                                color: colorInfo.modelData.color
                            }
                            ToolButton {
                                icon.name: "delete"
                                enabled: loginService.loggedIn

                                onClicked: colors.remove(colorInfo.modelData.id)
                            }
                            ToolButton {
                                icon.name: "edit"

                                onClicked: colorPopup.updateColor(colorInfo.modelData)
                            }
                            Label {
                                text: colorInfo.modelData.name
                            }
                            Label {
                                text: colorInfo.modelData.pantone_value
                            }
                        }
                        footer: ToolBar {
                            // Paginate buttons if more than one page
                            visible: colors.pages > 1
                            implicitWidth: parent.width

                            RowLayout {
                                anchors.fill: parent

                                Item { Layout.fillWidth: true /* spacer */ }
                                Repeater {
                                    model: colors.pages

                                    ToolButton {
                                        text: qsTr("Page") + " " + page
                                        font.bold: colors.page === page

                                        required property int index
                                        readonly property int page: (index + 1)

                                        onClicked: colors.page = page
                                    }
                                }
                                Item { Layout.fillWidth: true /* spacer */ }
                            }
                        }
                    }
                }
            }
        }
    }
}
