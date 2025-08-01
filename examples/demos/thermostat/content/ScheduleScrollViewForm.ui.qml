// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Thermostat

ScrollView {
    id: scrollView

    required property Room room
    required property var scheduleViewRoot
    property bool isBackgroundVisible: false
    property int timeScheduleHeight: 361
    property int timeScheduleWidth: 1087
    property int tempSetterHeight: 427
    property int tempSetterWidth: 1087

    clip: true
    padding: 0

    background: Rectangle {
        color: Constants.accentColor
        visible: scrollView.isBackgroundVisible
        radius: 12
    }

    ColumnLayout {
        width: scrollView.width
        height: scrollView.height

        TimeSchedule {
            id: timeSchedule
            Layout.preferredHeight: scrollView.timeScheduleHeight
            Layout.preferredWidth: scrollView.timeScheduleWidth
            Layout.alignment: Qt.AlignHCenter
            scheduleViewRoot: scrollView.scheduleViewRoot
        }

        TemperatureSetter {
            Layout.preferredHeight: scrollView.tempSetterHeight
            Layout.preferredWidth: scrollView.tempSetterWidth
            Layout.alignment: Qt.AlignHCenter
            scheduleViewRoot: scrollView.scheduleViewRoot
        }
    }

    states: [
        State {
            name: "desktopLayout"
            when: Constants.isBigDesktopLayout || Constants.isSmallDesktopLayout
            PropertyChanges {
                target: scrollView
                timeScheduleHeight: 361
                timeScheduleWidth: 1087
                tempSetterHeight: 427
                tempSetterWidth: 1087
                isBackgroundVisible: false
            }
        },
        State {
            name: "mobileLayout"
            when: Constants.isMobileLayout
            PropertyChanges {
                target: scrollView
                timeScheduleHeight: 314
                timeScheduleWidth: 327
                tempSetterHeight: 529
                tempSetterWidth: 327
                isBackgroundVisible: false
            }
        },
        State {
            name: "smallLayout"
            when: Constants.isSmallLayout
            PropertyChanges {
                target: scrollView
                timeScheduleHeight: 230
                timeScheduleWidth: 400
                tempSetterHeight: 370
                tempSetterWidth: 400
                isBackgroundVisible: true
            }
        }
    ]
}
