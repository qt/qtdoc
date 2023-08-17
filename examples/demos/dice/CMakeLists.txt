# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.14)
project(dice LANGUAGES CXX)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick Quick3D Quick3DPhysics Multimedia Sensors)

qt_standard_project_setup()

qt_add_executable(dice
    main.cpp
)

set_target_properties(dice PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(dice PRIVATE
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

qt_add_resources(dice "qml"
    PREFIX
        "/"
    FILES
        ${qml_resource_files}
)

install(TARGETS dice
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
