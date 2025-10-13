// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: nameTumbler
    width: ApplicationConfig.responsiveSize(544)
    height: ApplicationConfig.responsiveSize(775)
    color: "transparent"
    radius: ApplicationConfig.responsiveSize(16)

    property int rowHeight: adjectiveTumbler.height / adjectiveTumbler.visibleItemCount
    property var sourceModel

    SortFilterProxyModel {
        id: adjectivesProxy
        model: nameTumbler.sourceModel
        filters: [
            FunctionFilter {
                component AdjRoleData: QtObject { property string group }
                function filter(d: AdjRoleData) : bool {
                    return d.group === "adjectives"
                }
            }
        ]
        function setSelected(index_) {
            let proxyIndex = -1
            for (let i = 0; i < model.count; ++i) {
                const it = model.get(i)
                if (it.group === "adjectives") {
                    ++proxyIndex
                    if (proxyIndex === index_)
                        it.selected = true
                    else if (it.selected)
                        it.selected = false
                }
            }
        }
    }

    SortFilterProxyModel {
        id: nounProxy
        model: nameTumbler.sourceModel
        filters: [
            FunctionFilter {
                component NounRoleData: QtObject { property string group }
                function filter(d: NounRoleData) : bool {
                    return d.group === "noun"
                }
            }
        ]
        function setSelected(index_) {
            let proxyIndex = -1
            for (let i = 0; i < model.count; ++i) {
                const it = model.get(i)
                if (it.group === "noun") {
                    ++proxyIndex
                    if (proxyIndex === index_)
                        it.selected = true
                    else if (it.selected)
                        it.selected = false
                }
            }
        }
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        y: adjectiveTumbler.y + (adjectiveTumbler.height - nameTumbler.rowHeight) / 2
        width: adjectiveTumbler.width * 2
        height: 1
        color: "#2269EE"
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        y: adjectiveTumbler.y + (adjectiveTumbler.height + nameTumbler.rowHeight) / 2
        width: adjectiveTumbler.width * 2
        height: 1
        color: "#2269EE"
    }

    GridLayout {
        id: nameLayout
        anchors.fill: parent
        anchors.margins: ApplicationConfig.responsiveSize(32)
        rows: 2
        columns: 2
        rowSpacing: ApplicationConfig.responsiveSize(32)

        ToyLabel {
            id: nameTublerTitle
            Layout.row: 0
            Layout.column: 0
            Layout.columnSpan: 2
            Layout.leftMargin: ApplicationConfig.responsiveSize(375)
            text: qsTr("Pick a name for your toy!")
            wrapMode: Text.Wrap
            textStyle: ApplicationConfig.TextStyle.H2_Bold
        }

        Tumbler {
            id: adjectiveTumbler
            Layout.row: 1
            Layout.column: 0
            Layout.preferredWidth: ApplicationConfig.isPortrait ?
                                       ApplicationConfig.responsiveSize(800) :
                                       ApplicationConfig.responsiveSize(900)
            Layout.preferredHeight: ApplicationConfig.isPortrait ?
                                        ApplicationConfig.responsiveSize(800) :
                                        ApplicationConfig.responsiveSize(900)
            Layout.alignment: Qt.AlignHCenter
            model: adjectivesProxy
            currentIndex: 5
            onCurrentIndexChanged: adjectivesProxy.setSelected(currentIndex)
            delegate: Item {
                required property var name
                required property int index
                opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)

                ToyLabel {
                    anchors.centerIn: parent
                    text: name
                    color: index === adjectiveTumbler.currentIndex ? "#2269EE" : "#6A6A8D"
                    font {
                        styleName: index === adjectiveTumbler.currentIndex ? "Bold" : "Regular"
                        pixelSize: index === adjectiveTumbler.currentIndex ? 18 : 12
                        family: "DynaPuff"
                    }
                }
            }
            Component.onCompleted: adjectivesProxy.setSelected(currentIndex)
        }

        Tumbler {
            id: nounTumbler
            Layout.row: 1
            Layout.column: 1
            Layout.preferredWidth: ApplicationConfig.isPortrait ?
                                       ApplicationConfig.responsiveSize(800) :
                                       ApplicationConfig.responsiveSize(900)
            Layout.preferredHeight: ApplicationConfig.isPortrait ?
                                        ApplicationConfig.responsiveSize(800) :
                                        ApplicationConfig.responsiveSize(900)
            Layout.alignment: Qt.AlignHCenter
            model: nounProxy
            currentIndex: 5
            onCurrentIndexChanged: nounProxy.setSelected(currentIndex)
            delegate: Item {
                required property var name
                required property int index
                opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)

                ToyLabel {
                    anchors.centerIn: parent
                    text: name
                    color: index === nounTumbler.currentIndex ? "#2269EE" : "#6A6A8D"
                    font {
                        styleName: index === nounTumbler.currentIndex ? "Bold" : "Regular"
                        pixelSize: index === nounTumbler.currentIndex ? 18 : 12
                        family: "DynaPuff"
                    }
                }
            }
            Component.onCompleted: nounProxy.setSelected(currentIndex)
        }
    }
}
