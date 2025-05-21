// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import StocQt

Rectangle {
    id: star
    width: 24
    height: 24
    color: "transparent"

    property bool isFavorite
    property bool favoritesFull: false
    property string stock: "id"

    Component.onCompleted: StockEngine.onFavoritesChanged.connect(setFavoritesFull)

    function setFavoritesFull(full) {
        if (star)
            star.favoritesFull = full
    }

    Image {
        id: starFilled
        visible: isFavorite
        source: "../images/starFilled.svg"
        MouseArea {
            id: buttonFilled
            anchors.fill: parent
            onClicked: StockEngine.removeFavorite(stock)
        }
    }

    Image {
        id: starEmpty
        visible: !isFavorite
        source: favoritesFull? "../images/starMuted.svg" : "../images/starEmpty.svg"

        MouseArea {
            visible: !favoritesFull
            id: buttonEmpty
            anchors.fill: parent
            onClicked: StockEngine.addFavorite(stock)
        }
    }
}

