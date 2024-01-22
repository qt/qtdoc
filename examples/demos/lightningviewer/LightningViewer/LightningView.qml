// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls

Item {
    visible: true

    MapView {
        id: mapView
        anchors.fill: parent
        zoomLevel: 5
        mapType: actionsLayer.mapType
        lightningLayerVisible: actionsLayer.lightningLayerVisible
        distanceLayerVisible: actionsLayer.distanceLayerVisible
    }

    ActionsLayer {
        id: actionsLayer
        anchors.fill: parent
        anchors.margins: 15
        lightningLayerVisible: true
        distanceLayerVisible: false
        onRecenterRequested: mapView.recenter();
    }

    Binding {
        target: LightningController
        property: "distanceTimeLayerEnabled"
        value: actionsLayer.distanceLayerVisible
    }
}
