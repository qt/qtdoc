# Copyright (C) 2025 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

set(assets_animations
    animations/universalRiggedHead_rotation_0.qad
    animations/universalRiggedLCalf_rotation_0.qad
    animations/universalRiggedLCollarbone_rotation_0.qad
    animations/universalRiggedLForearm_rotation_0.qad
    animations/universalRiggedLThigh_rotation_0.qad
    animations/universalRiggedLUpperarm_rotation_0.qad
    animations/universalRiggedNeck_rotation_0.qad
    animations/universalRiggedRCalf_rotation_0.qad
    animations/universalRiggedRCollarbone_rotation_0.qad
    animations/universalRiggedRForearm_rotation_0.qad
    animations/universalRiggedRibcage_rotation_0.qad
    animations/universalRiggedRThigh_rotation_0.qad
    animations/universalRiggedRUpperarm_rotation_0.qad
    animations/universalRiggedSpine1_rotation_0.qad
    animations/universalRiggedSpine2_rotation_0.qad
    animations/universalRiggedSpine3_rotation_0.qad
)

qt_target_qml_sources(${TARGET_NAME}
    PREFIX "/qt/qml/ToyCustomizer/qml/"
    RESOURCES ${assets_animations}
)

set(clean_animations "${assets_animations}")
list(TRANSFORM clean_animations PREPEND "${CMAKE_CURRENT_SOURCE_DIR}/")
set_property(DIRECTORY APPEND PROPERTY ADDITIONAL_CLEAN_FILES "${clean_animations}")
