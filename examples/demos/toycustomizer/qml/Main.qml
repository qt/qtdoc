// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

pragma ComponentBehavior: Bound

ApplicationWindow {
    minimumWidth: 608
    minimumHeight: 960
    width: 1536
    height: 864
    visible: true
    title: qsTr("Toy Customizer")

    enum Step {
        None,
        Choose,
        Customize,
        Overview
    }

    onWidthChanged: ApplicationConfig.updateApplicationSize(width, height)
    onHeightChanged: ApplicationConfig.updateApplicationSize(width, height)
    Component.onCompleted: {
        minimumWidth = Math.min(ApplicationConfig.appMinimumWidth, screen.width)
        minimumHeight = Math.min(ApplicationConfig.appMinimumHeight, screen.height)
        width = screen.width * 0.7
        height = screen.height * 0.7
        ApplicationConfig.updateApplicationSize(width, height)
    }

    background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#DAEBFF" }
            GradientStop { position: 0.25; color: "#DAEBFF" }
            GradientStop { position: 0.65; color: "#91C9FF" }
            GradientStop { position: 0.80; color: "#91C9FF" }
            GradientStop { position: 1.0; color: "#A2D1FF" }
        }
    }

    AccessoryModel {
        id: __accessoryModel
    }

    ColumnLayout {
        anchors {
            fill: parent
            leftMargin: ApplicationConfig.responsiveSize(200)
            rightMargin: ApplicationConfig.responsiveSize(200)
            topMargin: ApplicationConfig.responsiveSize(150)
        }
        ToyHeader {
            visible: currentPageStep !== Main.Step.None
            currentPageStep: stackView.currentItem.pageStep ?? Main.Step.None
            headingText: stackView.currentItem.headingText ?? ""
            bodyText: stackView.currentItem.headerBodyText ?? ""
            pageModel: stepModel
            Layout.fillWidth: true
            onExitRequested: stackView.popToIndex(0)
        }
        StackView {
            id: stackView
            initialItem: mainPage
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    Component {
        id: mainPage
        MainPage {
            readonly property int pageStep: Main.Step.None
            isCurrent: stackView.depth === 1
            onStartRequested: stackView.push(toyGalleryPage)
        }
    }

    Component {
        id: toyGalleryPage
        ToyGalleryPage {
            readonly property int pageStep: Main.Step.Choose
            readonly property string headingText: qsTr("Choose your new buddy")
            onToySelected: (index) => {
                if (index < 0)
                    return
                const item = stackView.push(toyConfirmPage)
                item.toyIndex = index
            }
        }
    }

    Component {
        id: toyConfirmPage
        ToyConfirmPage {
            readonly property int pageStep: Main.Step.Choose
            readonly property string headingText: qsTr("Get to know your buddy")
            onCancelled: stackView.pop()
            onConfirmed: {
                if (toyIndex < 0)
                    return
                const item = stackView.push(toyCustomizePage)
                item.toyIndex = toyIndex
            }
        }
    }

    Component {
        id: toyCustomizePage
        ToyCustomizePage {
            accessoryModel: __accessoryModel
            readonly property int pageStep: Main.Step.Customize
            readonly property string headingText: qsTr("Add some personality")
            readonly property string headerBodyText: qsTr("You can rotate the toy to preview")

            onCancelled: stackView.pop()
            onConfirmed: {
                if (toyIndex < 0)
                    return
                const item = stackView.push(toyOverviewPage, {toyIndex: toyIndex})
            }
            onShowMaximizeViewRequested: page => stackView.push(page)
            onHideMaximizeViewRequested: stackView.pop()
        }
    }

    Component {
        id: toyOverviewPage
        OverViewPage {
            accessoryModel: __accessoryModel
            readonly property int pageStep: Main.Step.Overview
            readonly property string headingText: qsTr("Review your order")
            onCancelled: stackView.pop()
            // TODO: onConfirmed: go to final page
        }
    }

    ListModel {
        id: stepModel
        ListElement {
            text: qsTr("Choose a toy")
            step: Main.Step.Choose
        }
        ListElement {
            text: qsTr("Customize")
            step: Main.Step.Customize
        }
        ListElement {
            text: qsTr("Order overview")
            step: Main.Step.Overview
        }
    }
}
