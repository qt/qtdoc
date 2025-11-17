// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl

Rectangle {
    id: accessoryView

    property alias model: groupFilterProxyModel.model
    property int totalSelectedAccessory: 0
    property var target: null

    color: "#FFFFFF"
    clip: true
    topLeftRadius: ApplicationConfig.responsiveSize(56)
    topRightRadius: ApplicationConfig.responsiveSize(56)
    bottomLeftRadius: ApplicationConfig.isPortrait ? 0 : ApplicationConfig.responsiveSize(56)
    bottomRightRadius: ApplicationConfig.isPortrait ? 0 : ApplicationConfig.responsiveSize(56)

    function setAccessoryVisibility(key, vis) {
        if (key === "bracletsVisible") {
            AccessoryState["metalBracelet_RightVisible"] = vis
            AccessoryState["metalBracelet_LeftVisible"] = vis
            return
        }
        AccessoryState[key] = vis
    }

    function resetAllAccessories() {
        const accessoryModel = accessoryView.model
        for (let i = 0; i < accessoryModel.count; ++i) {
            const item = accessoryModel.get(i)
            const isDefaultEyes = (item.group === "eyes" && item.name === "Small Eyes")
            accessoryModel.set(i, { selected: isDefaultEyes, color: "" })
            accessoryView.setAccessoryVisibility(item.key, isDefaultEyes)
        }
        accessoryView.totalSelectedAccessory = 0
    }

    TabBar {
        id: tabBar

        property int tabWidth: Math.max(width / 5, ApplicationConfig.responsiveSize(415))
        property int tabHeight: ApplicationConfig.responsiveSize(144)

        contentWidth: ApplicationConfig.responsiveSize(1760)
        contentHeight: tabHeight
        clip: true

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            leftMargin: ApplicationConfig.responsiveSize(120)
            rightMargin: ApplicationConfig.responsiveSize(120)
            topMargin: ApplicationConfig.responsiveSize(120)
        }

        background: Rectangle {
            radius: 20
            color: "white"
            border.width: 2
            border.color: "#D7D6E1"
        }

        TabButton {
            id: headwearTabButton
            width: tabBar.tabWidth
            height: tabBar.height
            anchors.left: parent.left

            contentItem: IconLabel {
                text: qsTr("Headwear")
                color: headwearTabButton.checked ? "#EFF7FF" : "#6A6A8D"
                font.family: "Winky Sans"
                font.pixelSize: Math.round(ApplicationConfig.responsiveSize(48))
                font.weight: headwearTabButton.checked ? Font.Bold : Font.Normal
                icon.source: "icons/headwear.svg"
                icon.width: ApplicationConfig.responsiveSize(36)
                icon.height: ApplicationConfig.responsiveSize(36)
                icon.color: headwearTabButton.checked ? "#EFF7FF" : "#6A6A8D"
                spacing: ApplicationConfig.responsiveSize(12)
                anchors.centerIn: parent
            }

            background: Rectangle {
                radius: 20
                color: "#2269EE"
                border.color: "#5EAAFC"
                border.width: ApplicationConfig.responsiveSize(4)
                visible: headwearTabButton.checked
            }
        }

        TabButton {
            id: eyewearTabButton
            width: tabBar.tabWidth
            height: tabBar.height
            anchors.left: headwearTabButton.right

            contentItem: IconLabel {
                text: qsTr("Eyewear")
                color: eyewearTabButton.checked ? "#EFF7FF" : "#6A6A8D"
                font.family: "Winky Sans"
                font.pixelSize: Math.round(ApplicationConfig.responsiveSize(48))
                font.weight: eyewearTabButton.checked ? Font.Bold : Font.Normal
                icon.source: "icons/eyewear.svg"
                icon.width: ApplicationConfig.responsiveSize(36)
                icon.height: ApplicationConfig.responsiveSize(36)
                icon.color: eyewearTabButton.checked ? "#EFF7FF" : "#6A6A8D"
                spacing: ApplicationConfig.responsiveSize(12)
                anchors.centerIn: parent
            }

            background: Rectangle {
                radius: 20
                color: "#2269EE"
                border.color: "#5EAAFC"
                border.width: ApplicationConfig.responsiveSize(4)
                visible: eyewearTabButton.checked
            }
        }

        TabButton {
            id: eyesTabButton
            width: tabBar.tabWidth
            height: tabBar.height
            anchors.left: eyewearTabButton.right
            contentItem: IconLabel {
                text: qsTr("Eyes")
                color: eyesTabButton.checked ? "#EFF7FF" : "#6A6A8D"
                font.family: "Winky Sans"
                font.pixelSize: Math.round(ApplicationConfig.responsiveSize(48))
                font.weight: eyesTabButton.checked ? Font.Bold : Font.Normal
                icon.source: "icons/eyes.svg"
                icon.width: ApplicationConfig.responsiveSize(36)
                icon.height: ApplicationConfig.responsiveSize(36)
                icon.color: eyesTabButton.checked ? "#EFF7FF" : "#6A6A8D"
                spacing: ApplicationConfig.responsiveSize(12)
                anchors.centerIn: parent
            }
            background: Rectangle {
                radius: 20
                color: "#2269EE"
                border.color: "#5EAAFC"
                border.width: ApplicationConfig.responsiveSize(4)
                visible: eyesTabButton.checked
            }
        }

        TabButton {
            id: itemsTabButton
            width: tabBar.tabWidth
            height: tabBar.height
            anchors.left: eyesTabButton.right
            contentItem: IconLabel {
                text: qsTr("Items")
                color: itemsTabButton.checked ? "#EFF7FF" : "#6A6A8D"
                font.family: "Winky Sans"
                font.pixelSize: Math.round(ApplicationConfig.responsiveSize(48))
                font.weight: itemsTabButton.checked ? Font.Bold : Font.Normal
                icon.source: "icons/items.svg"
                icon.width: ApplicationConfig.responsiveSize(36)
                icon.height: ApplicationConfig.responsiveSize(36)
                icon.color: itemsTabButton.checked ? "#EFF7FF" : "#6A6A8D"
                spacing: ApplicationConfig.responsiveSize(12)
                anchors.centerIn: parent
            }
            background: Rectangle {
                radius: 20
                color: "#2269EE"
                border.color: "#5EAAFC"
                border.width: ApplicationConfig.responsiveSize(4)
                visible: itemsTabButton.checked
            }
        }

        TabButton {
            id: nameTabButton
            width: tabBar.tabWidth
            height: tabBar.height
            anchors.left: itemsTabButton.right
            contentItem: IconLabel {
                text: qsTr("Name")
                color: nameTabButton.checked ? "#EFF7FF" : "#6A6A8D"
                font.family: "Winky Sans"
                font.pixelSize: Math.round(ApplicationConfig.responsiveSize(48))
                font.weight: nameTabButton.checked ? Font.Bold : Font.Normal
                icon.source: "icons/names.svg"
                icon.width: ApplicationConfig.responsiveSize(36)
                icon.height: ApplicationConfig.responsiveSize(36)
                icon.color: nameTabButton.checked ? "#EFF7FF" : "#6A6A8D"
                spacing: ApplicationConfig.responsiveSize(12)
                anchors.centerIn: parent
            }
            background: Rectangle {
                radius: 20
                color: "#2269EE"
                border.color: "#5EAAFC"
                border.width: ApplicationConfig.responsiveSize(4)
                visible: nameTabButton.checked
            }
        }
    }

    SortFilterProxyModel {
        id: groupFilterProxyModel
        property string groupFilter: accessoryView.model.groups()[tabBar.currentIndex] ?? ""
        onGroupFilterChanged: {
            invalidate()
            listView.positionViewAtBeginning()
        }
        filters: [
            FunctionFilter {
                component RoleData: QtObject { property string group }
                function filter(data: RoleData) : bool {
                    return (data.group === groupFilterProxyModel.groupFilter)
                }
            }
        ]
    }

    ListView {
        id: listView
        visible: tabBar.currentIndex !== 4
        anchors {
            top: tabBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: ApplicationConfig.responsiveSize(200)
            rightMargin: ApplicationConfig.responsiveSize(200)
            bottomMargin: ApplicationConfig.responsiveSize(100)
            topMargin: ApplicationConfig.responsiveSize(100)
        }

        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.SnapOneItem
        spacing: ApplicationConfig.responsiveSize(64)
        clip: true

        model: groupFilterProxyModel

        function resetAll(group :string) {
            let accessoryModel = accessoryView.model
            for (let i = 0; i < accessoryModel.count; i++) {
                const item = accessoryModel.get(i)
                if ((item.group === group) && item.selected) {
                    item.selected = false
                    item.color = ""
                    accessoryView.setAccessoryVisibility(item.key, false)
                    break // since selecting two items from the same category is not possible
                }
            }
        }

        function updateTotalSelectedAccessory() {
            let total = 0
            const accessoryModel = accessoryView.model
            for (let i = 0; i < accessoryModel.count; ++i) {
                const item = accessoryModel.get(i)
                if (item.selected) {
                    if (item.name === "Small Eyes")
                        continue
                    ++total
                }
            }
            accessoryView.totalSelectedAccessory = total
        }

        delegate: CustomizationCard {
            required property var model
            required property string group
            required property string name
            required property url image
            required property string color
            required property string key
            required selected
            required newPrice
            required oldPrice
            required modelRating

            function setSelected(selected :bool) {
                model.selected = selected
                accessoryView.setAccessoryVisibility(key, selected)
                ListView.view.updateTotalSelectedAccessory()
            }

            cardName: name
            cardImageSource: Qt.resolvedUrl(image)
            selectedColorName: color
            isExclusive: tabBar.currentItem === eyesTabButton

            onChooseRequested: {
                ListView.view.resetAll(group)
                setSelected(true)
            }

            onRemoveRequested: {
                if (isExclusive) {
                    console.warn("No eyes is selected")
                    return
                }
                setSelected(false)
            }

            onColorChosen: (colorName) => model.color = colorName
        }
    }

    NameTumbler {
        id: nameTumbler
        visible: tabBar.currentIndex === 4
        sourceModel: accessoryView.model
        anchors {
            top: tabBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: ApplicationConfig.responsiveSize(200)
            rightMargin: ApplicationConfig.responsiveSize(200)
        }
    }
}
