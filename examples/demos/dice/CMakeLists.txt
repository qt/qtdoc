# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

cmake_minimum_required(VERSION 3.14)
set(appname "qtdice")
project(${appname} LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick Quick3D Quick3DPhysics Multimedia Sensors)

qt_standard_project_setup()

qt_add_executable(${appname}
    main.cpp
)

set_target_properties(${appname} PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(${appname} PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::Quick3D
    Qt6::Quick3DPhysics
    Qt6::Multimedia
    Qt6::Sensors
)

# Resources:
set(qml_resource_files
    main.qml
    Dice_low.qml
    DiceSpawner.qml
    PhysicalDie.qml
    PhysicalTable.qml
    Scene.qml
    RoundTable.qml
    Carpet.qml

    #icons
    Menu_Icon.svg

    #maps
    maps/carpet_texture_baseColor.jpeg
    maps/M_Side_Table_Natural_Wenge_Wood_4K_baseColor_small.jpg
    maps/M_Side_Table_Natural_Wenge_Wood_4K_metallicRoughness_small.png
    maps/M_Side_Table_Natural_Wenge_Wood_4K_normal_small.png

    #meshes
    meshes/cube_001.mesh
    meshes/object_2.mesh
    meshes/object_3.mesh
    meshes/side_Table_Pine_LOD0_M_Side_Table_Natural_Wenge_Wood_4K_0.mesh

    #sounds
    sounds/onedice.wav
    sounds/rolling.wav
)
if(ANDROID)
    set_target_properties(${appname} PROPERTIES
        QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
        QT_ANDROID_TARGET_SDK_VERSION "33")
endif()

if(IOS)
    set(asset_catalog_path "ios/Assets.xcassets")
    target_sources(${appname} PRIVATE "${asset_catalog_path}")
    set_source_files_properties(${asset_catalog_path} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)
    set_target_properties(${appname}
        PROPERTIES XCODE_ATTRIBUTE_ASSETCATALOG_COMPILER_APPICON_NAME AppIcon)
endif()

qt_add_resources(${appname} "qml"
    PREFIX
        "/"
    FILES
        ${qml_resource_files}
)

install(TARGETS ${appname}
    BUNDLE  DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

qt_generate_deploy_qml_app_script(
    TARGET ${appname}
    OUTPUT_SCRIPT deploy_script
    MACOS_BUNDLE_POST_BUILD
    NO_UNSUPPORTED_PLATFORM_ERROR
    DEPLOY_USER_QML_MODULES_ON_UNSUPPORTED_PLATFORM
)
install(SCRIPT ${deploy_script})
