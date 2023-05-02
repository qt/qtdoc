# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(maroon LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/maroon")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

qt_add_executable(maroon
    main.cpp
)

set_target_properties(maroon PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(maroon PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

# Resources:
set(maroon_resource_files
    "content/BuildButton.qml"
    "content/GameCanvas.qml"
    "content/GameOverScreen.qml"
    "content/InfoBar.qml"
    "content/NewGameScreen.qml"
    "content/SoundEffect.qml"
    "content/audio/bomb-action.wav"
    "content/audio/catch-action.wav"
    "content/audio/catch.wav"
    "content/audio/currency.wav"
    "content/audio/factory-action.wav"
    "content/audio/melee-action.wav"
    "content/audio/projectile-action.wav"
    "content/audio/shooter-action.wav"
    "content/gfx/background.png"
    "content/gfx/bomb-action.png"
    "content/gfx/bomb-idle.png"
    "content/gfx/bomb.png"
    "content/gfx/button-help.png"
    "content/gfx/button-play.png"
    "content/gfx/catch-action.png"
    "content/gfx/catch.png"
    "content/gfx/cloud.png"
    "content/gfx/currency.png"
    "content/gfx/dialog-bomb.png"
    "content/gfx/dialog-factory.png"
    "content/gfx/dialog-melee.png"
    "content/gfx/dialog-pointer.png"
    "content/gfx/dialog-shooter.png"
    "content/gfx/dialog.png"
    "content/gfx/factory-action.png"
    "content/gfx/factory-idle.png"
    "content/gfx/factory.png"
    "content/gfx/grid.png"
    "content/gfx/help.png"
    "content/gfx/lifes.png"
    "content/gfx/logo-bubble.png"
    "content/gfx/logo-fish.png"
    "content/gfx/logo.png"
    "content/gfx/melee-action.png"
    "content/gfx/melee-idle.png"
    "content/gfx/melee.png"
    "content/gfx/mob-idle.png"
    "content/gfx/mob.png"
    "content/gfx/points.png"
    "content/gfx/projectile-action.png"
    "content/gfx/projectile.png"
    "content/gfx/scores.png"
    "content/gfx/shooter-action.png"
    "content/gfx/shooter-idle.png"
    "content/gfx/shooter.png"
    "content/gfx/sunlight.png"
    "content/gfx/text-1.png"
    "content/gfx/text-2.png"
    "content/gfx/text-3.png"
    "content/gfx/text-blank.png"
    "content/gfx/text-gameover.png"
    "content/gfx/text-go.png"
    "content/gfx/wave.png"
    "content/logic.js"
    "content/mobs/MobBase.qml"
    "content/towers/Bomb.qml"
    "content/towers/Factory.qml"
    "content/towers/Melee.qml"
    "content/towers/Ranged.qml"
    "content/towers/TowerBase.qml"
    "maroon.qml"
)

qt_add_resources(maroon "maroon"
    PREFIX
        "/demos/maroon"
    FILES
        ${maroon_resource_files}
)

if(TARGET Qt6::Multimedia)
    target_link_libraries(maroon PRIVATE
        Qt6::Multimedia
    )
endif()

install(TARGETS maroon
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
