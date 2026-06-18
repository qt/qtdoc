# Copyright (C) 2025 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

if(NOT QT_FEATURE_system_zlib)
    find_package(Qt6 COMPONENTS ZlibPrivate)
elseif(NOT TARGET WrapZLIB::WrapZLIB)
    qt_find_package(WrapZLIB PROVIDED_TARGETS WrapZLIB::WrapZLIB)
endif()

qt_internal_add_qml_module(QmlAssetDownloaderPrivate
    URI "Qt.labs.assetdownloader"
    STATIC
    INTERNAL_MODULE
    SOURCES
        assetdownloader.cpp
        assetdownloader.h
        qqmlassetdownloader_p.h
        qqmlassetdownloader.cpp
        qzipreader_p.h
        qzipreader.cpp
    LIBRARIES
        Qt6::CorePrivate
    PUBLIC_LIBRARIES
        Qt6::Concurrent
        Qt6::Core
        Qt6::Network
        Qt6::Qml
        Qt6::TaskTree
)

qt_internal_extend_target(QmlAssetDownloaderPrivate CONDITION NOT QT_FEATURE_system_zlib
    LIBRARIES
        Qt::ZlibPrivate
)

qt_internal_extend_target(QmlAssetDownloaderPrivate CONDITION QT_FEATURE_system_zlib
    LIBRARIES
        WrapZLIB::WrapZLIB
)
