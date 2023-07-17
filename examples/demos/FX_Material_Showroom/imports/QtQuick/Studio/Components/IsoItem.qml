// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick 2.0
import QtQuick 2.9
import QtQuick.Extras 1.4

/*!
    \qmltype IsoItem
    \inqmlmodule QtQuick.Studio.Components
    \since QtQuick.Studio.Components 1.0
    \inherits ShapePath
    \ingroup qtquickstudio-components

    \brief An ISO 7000 icon.

    The IsoItem type specifies an icon from an ISO 7000 icon library as a
    \l [QtQuickExtras] {Picture} type. The icon to use for the type and its
    color can be specified.

    \section2 Example Usage

    You can use the IsoItem type in \QDS to add ISO 7000 icons.

    \image studio-flipable.png

    The QML code looks as follows:

    \code
    IsoItem {
        id: arrowIsoIcon
        color: "#808080"
        anchors.fill: parent
        source: "./iso-icons/iso_grs_7000_4_0251.dat"
    }
    \endcode
*/

Picture {

}
