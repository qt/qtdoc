// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Page {
    id: toyCustomizePage

    property alias toyIndex: toyView.toyIndex
    property bool reset: false
    required property AccessoryModel accessoryModel

    signal cancelled
    signal confirmed
    signal showMaximizeViewRequested(page: Component)
    signal hideMaximizeViewRequested

    Component.onCompleted: {
        if (reset)
            accessoryView.resetAllAccessories()
    }

    background: Item { visible: false }

    ColumnLayout {
        id: portraitGridLayout
        visible: ApplicationConfig.isPortrait
        anchors.fill: parent

        LayoutItemProxy {
            target: toyView
            Layout.fillWidth: true
            Layout.preferredWidth: ApplicationConfig.responsiveSize(708)
            Layout.preferredHeight: ApplicationConfig.responsiveSize(952)
            Layout.alignment: Qt.AlignVCenter | Qt.AlignTop
            Layout.leftMargin: ApplicationConfig.responsiveSize(200)
            Layout.rightMargin: ApplicationConfig.responsiveSize(200)
        }

        LayoutItemProxy {
            target: reviewOrder
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            Layout.rightMargin: ApplicationConfig.responsiveSize(200)
            Layout.bottomMargin: ApplicationConfig.responsiveSize(100)
            Layout.preferredWidth: Math.round(ApplicationConfig.responsiveSize(444))
            Layout.preferredHeight: Math.round(ApplicationConfig.responsiveSize(144))
        }

        LayoutItemProxy {
            target: accessoryView
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    GridLayout {
        id: landscapeLayout
        columns: 2
        visible: !ApplicationConfig.isPortrait
        columnSpacing: ApplicationConfig.responsiveSize(80)
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: ApplicationConfig.responsiveSize(200)
            rightMargin: ApplicationConfig.responsiveSize(200)
        }

        state: height < toyCustomizePage.height ? "" : "narrow"
        states: State {
            name: "narrow"
            AnchorChanges {
                target: landscapeLayout
                anchors {
                    top: landscapeLayout.parent.top
                    verticalCenter: undefined
                }
            }
        }

        LayoutItemProxy {
            target: reviewOrder
            Layout.alignment: Qt.AlignRight
            Layout.columnSpan: 2
            Layout.bottomMargin: ApplicationConfig.responsiveSize(48)
        }

        LayoutItemProxy {
            target: toyView
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        LayoutItemProxy {
            target: accessoryView
            Layout.fillWidth: true
        }
    }

    Component {
        id: maximizeView
        MaximizeView {
            accessoryModel: toyCustomizePage.accessoryModel
            toyIndex: toyCustomizePage.toyIndex
            onHideRequested: toyCustomizePage.hideMaximizeViewRequested()
        }
    }

    AccessoryModel {
        id: __accessoryModel
    }

    ToyView {
        id: toyView
        implicitWidth: ApplicationConfig.responsiveSize(2080)
        accessoryModel: toyCustomizePage.accessoryModel
        onHideRequested: toyCustomizePage.cancelled()
        onShowRequested: toyCustomizePage.showMaximizeViewRequested(maximizeView)
    }

    AccessoryView {
        id: accessoryView
        implicitWidth: ApplicationConfig.responsiveSize(2080)
        target: toyView.toy
        model: toyCustomizePage.accessoryModel
    }

    Item {
        id: reviewOrder
        readonly property real paddings: Math.round(ApplicationConfig.responsiveSize(48))
        implicitWidth: orderButton.implicitWidth + paddings
        implicitHeight: orderButton.implicitHeight + paddings

        ToyButton {
            id: orderButton
            textStyle: ApplicationConfig.TextStyle.Button_L
            text: qsTr("Review Order")
            anchors {
                left: parent.left
                bottom: parent.bottom
            }

            onClicked: toyCustomizePage.confirmed()
        }

        Rectangle {
            id: totalAccessory
            width: Math.round(ApplicationConfig.responsiveSize(115))
            height: Math.round(ApplicationConfig.responsiveSize(115))
            radius: width / 2
            color: "#FFFFFF"
            visible: accessoryView.totalSelectedAccessory > 0 ? true : false

            anchors {
                top: parent.top
                right: parent.right
            }

            ToyLabel {
                anchors.centerIn: parent
                text: accessoryView.totalSelectedAccessory
                font {
                    family: "DynaPuff"
                    pixelSize: 13
                }
            }
        }
    }
}
