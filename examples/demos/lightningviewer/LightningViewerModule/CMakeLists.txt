# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

find_package(Qt6 REQUIRED COMPONENTS Positioning Quick WebSockets)

set_source_files_properties(LightningViewConfig.qml MapType.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(LightningViewerModule
    URI LightningViewerModule
    VERSION 1.0
    SOURCES
        controller.h controller.cpp
        laststrikeinfo.h
        lightningitemdata.h lightningitemdata.cpp
        lightningitemmodel.h lightningitemmodel.cpp
        lightningprovider.h lightningprovider.cpp
    QML_FILES
        ActionsLayer.qml
        DistanceTimeLayer.qml
        LightningMapLayer.qml
        LightningView.qml
        LightningViewConfig.qml
        Main.qml
        MapLayersDrawer.qml
        MapLayersItem.qml
        MapType.qml
        MapView.qml
        SwitchMap.qml
    RESOURCES
        icons/distance.svg
        icons/globe.svg
        icons/lightning-layer.svg
        icons/lightning-strike.svg
        icons/map-layers.svg
        icons/map.svg
        icons/recenter.svg
        icons/user-location.svg
)

target_link_libraries(LightningViewerModule PRIVATE
    Qt6::Positioning
    Qt6::Quick
    Qt6::WebSockets
)

install(TARGETS LightningViewerModule
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}/LightningViewerModule"
    LIBRARY DESTINATION "${CMAKE_INSTALL_BINDIR}/LightningViewerModule"
)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/qmldir
    DESTINATION "${CMAKE_INSTALL_BINDIR}/LightningViewerModule"
)
