// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls.Basic
import QtGraphs
import Thermostat

Pane {
    id: root
    anchors.fill: parent
    padding: 0

    required property list<int> energyValues
    required property list<real> tempValues

    background: Rectangle {
        radius: 12
        color: Constants.accentColor
    }

    ValueAxis {
        id: barChartAxisY

        min: 0
        max: 2000
        titleText: qsTr("Energy Usage [Wh]")
        titleColor: internal.energyBarColor
        tickInterval: 500
    }

    ValueAxis {
        id: splineChartAxisY

        alignment: Qt.AlignRight
        min: 0
        max: 40
        tickAnchor: 5
        tickInterval: 10
        titleText: qsTr("Temperature [°C]")
        titleColor: internal.splineChartColor
        lineVisible: false
    }

    ValueAxis {
        id: splineChartAxisX

        visible: false
        min: 0
        max: 365
    }

    BarCategoryAxis {
        id: barChartAxisX

        color: internal.energyBarColor
        gridVisible: false
        textElideMode: Qt.ElideNone
        categories: [qsTr("Jan"), qsTr("Feb"), qsTr("Mar"), qsTr("Apr"), qsTr("May"), qsTr("Jun"), qsTr("Jul"), qsTr("Aug"), qsTr("Sep"), qsTr("Oct"), qsTr("Nov"), qsTr("Dec")]
    }

    GraphsView {
        id: chart

        anchors.fill: parent
        marginLeft: 0
        marginRight: 0
        marginTop: 36
        marginBottom: 0

        axisX: barChartAxisX
        axisY: barChartAxisY

        theme: GraphsTheme {
            axisXLabelFont.family: "Titillium Web"
            axisXLabelFont.pixelSize: internal.axisFontSize
            axisYLabelFont.family: "Titillium Web"
            axisYLabelFont.pixelSize: internal.axisFontSize

            colorScheme: AppSettings.isDarkTheme ? GraphsTheme.ColorScheme.Dark : GraphsTheme.ColorScheme.Light
            backgroundVisible: false
        }

        BarSeries {
            id: mySeries

            barWidth: internal.barWidth

            BarSet {
                id: energySet

                label: "Energy Usage [Wh]"
                color: internal.energyBarColor
                borderWidth: 0
                values: root.energyValues.map(x => x) // list<int> -> list<var> hack
            }
        }

        SplineSeries {
            id: spline

            name: "Temperature [°C]"
            color: internal.splineChartColor
            width: internal.lineWidth

            axisX: splineChartAxisX
            axisY: splineChartAxisY

            Component.onCompleted: {
                for (let i = 0; i < root.tempValues.length; ++i) {
                    spline.append(i * 7, root.tempValues[i]);
                }
            }
        }
    }

    QtObject {
        id: internal

        property int fontSize: 14
        property int axisFontSize: 14
        property int lineWidth: 5
        property real barWidth: 0.5
        readonly property color energyBarColor: AppSettings.isDarkTheme ? "#2CDE85" : "#00414A"
        readonly property color splineChartColor: AppSettings.isDarkTheme ? "#D9D9D9" : "#2CDE85"
    }

    states: [
        State {
            name: "desktopLayout"
            when: Constants.isSmallDesktopLayout || Constants.isBigDesktopLayout
            PropertyChanges {
                target: internal
                fontSize: 14
                axisFontSize: 14
                lineWidth: 5
                barWidth: 0.5
            }
        },
        State {
            name: "mobileLayout"
            when: Constants.isMobileLayout
            PropertyChanges {
                target: internal
                fontSize: 10
                axisFontSize: 8
                lineWidth: 2
                barWidth: 0.7
            }
        },
        State {
            name: "smallLayout"
            when: Constants.isSmallLayout
            PropertyChanges {
                target: internal
                fontSize: 8
                axisFontSize: 10
                lineWidth: 2
                barWidth: 0.6
            }
        }
    ]
}
