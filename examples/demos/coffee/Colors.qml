// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

pragma Singleton
import QtQuick

Item {
    QtObject {
        id: light
        readonly property color background: "#ffffff"
        readonly property color textColor: "#121111"
        readonly property color borderColor: "#D8D8D8"
        readonly property color cardColor: "#FFFFFF"
        readonly property color caption: "#898989"
    }
    QtObject {
        id: dark
        readonly property color background: "#121212"
        readonly property color textColor: "#FEFEFE"
        readonly property color borderColor: "#3E3E3E"
        readonly property color cardColor: "#212121"
        readonly property color caption: "#898989"
    }

    Gradient {
        id: invertedGreyBorder
        GradientStop { position: 0.0; color: currentTheme.cardColor }
        GradientStop { position: 1.0; color: currentTheme.borderColor }
    }
    Gradient {
        id: greyBorder
        GradientStop { position: 0.0; color: currentTheme.borderColor }
        GradientStop { position: 1.0; color: currentTheme.cardColor }
    }
    Gradient {
        id: invertedGreenBorder
        // GradientStop positions are arbitrary
        GradientStop {
            position: 1.0
            color: "#18B969"
        }
        GradientStop {
            position: 0.66
            color: "#c718b969"
        }
        GradientStop {
            position: 0.33
            color: "#ab18b969"
        }
        GradientStop {
            position: 0.0
            color: currentTheme.cardColor
        }
    }
    Gradient {
        id: greenBorder
        GradientStop {
            position: 1.0
            color: currentTheme.cardColor
        }
        GradientStop {
            position: 0.66
            color: "#ab18b969"
        }
        GradientStop {
            position: 0.33
            color: "#c718b969"
        }
        GradientStop {
            position: 0.0
            color: "#18B969"
        }
    }
    Gradient {
        id: greenButtonGradient
        GradientStop {
            position: 0.3
            color: "#2CDE85"
        }
        GradientStop {
            position: 0.5
            color: "#24b46d"
        }
        GradientStop {
            position: 0.9
            color: "#9c219d60"
        }
    }
    Gradient {
        id: darkButtonGradient
        GradientStop {
           position: 0.2
            color: Colors.currentTheme.background
        }
        GradientStop {
            position: 0.5
            color: "#2a2a2a"
        }
        GradientStop {
            position: 0.9
            color: "#f72a2a2a"
        }
    }
    Gradient {
        id: lightButtonGradient
        GradientStop {
           position: 0.2
            color: Colors.currentTheme.background
        }
        GradientStop {
            position: 0.5
            color: "#eeeeee"
        }
        GradientStop {
            position: 0.9
            color: "#e6e6e6"
        }
    }
    property color green: "#1FC974"
    property color shadow: "white"
    property color border: "#898989"
    property color grey: "#585858"
    property var currentTheme: dark
    property alias dark: dark
    property alias light: light
    property alias invertedGreenBorder: invertedGreenBorder
    property alias invertedGreyBorder: invertedGreyBorder
    property alias greyBorder: greyBorder
    property alias greenBorder: greenBorder
    property alias darkButtonGradient: darkButtonGradient
    property alias lightButtonGradient: lightButtonGradient
    property alias greenButtonGradient: greenButtonGradient
}
