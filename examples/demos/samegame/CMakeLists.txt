# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(samegame LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}/demos/samegame")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick Sql)

qt_add_executable(samegame
    main.cpp
)

set_target_properties(samegame PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(samegame PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::Sql
)

# Resources:
set(samegame_resource_files
    "content/Block.qml"
    "content/BlockEmitter.qml"
    "content/Button.qml"
    "content/GameArea.qml"
    "content/LogoAnimation.qml"
    "content/MenuEmitter.qml"
    "content/PaintEmitter.qml"
    "content/PrimaryPack.qml"
    "content/PuzzleBlock.qml"
    "content/SamegameText.qml"
    "content/Settings.qml"
    "content/SimpleBlock.qml"
    "content/SmokeText.qml"
    "content/gfx/background-puzzle.png"
    "content/gfx/background.png"
    "content/gfx/bar.png"
    "content/gfx/blue-puzzle.png"
    "content/gfx/blue.png"
    "content/gfx/bubble-highscore.png"
    "content/gfx/bubble-puzzle.png"
    "content/gfx/but-game-1.png"
    "content/gfx/but-game-2.png"
    "content/gfx/but-game-3.png"
    "content/gfx/but-game-4.png"
    "content/gfx/but-game-new.png"
    "content/gfx/but-menu.png"
    "content/gfx/but-puzzle-next.png"
    "content/gfx/but-quit.png"
    "content/gfx/green-puzzle.png"
    "content/gfx/green.png"
    "content/gfx/icon-fail.png"
    "content/gfx/icon-ok.png"
    "content/gfx/icon-time.png"
    "content/gfx/logo-a.png"
    "content/gfx/logo-e.png"
    "content/gfx/logo-g.png"
    "content/gfx/logo-m.png"
    "content/gfx/logo-s.png"
    "content/gfx/logo.png"
    "content/gfx/particle-brick.png"
    "content/gfx/particle-paint.png"
    "content/gfx/particle-smoke.png"
    "content/gfx/red-puzzle.png"
    "content/gfx/red.png"
    "content/gfx/text-highscore-new.png"
    "content/gfx/text-highscore.png"
    "content/gfx/text-no-winner.png"
    "content/gfx/text-p1-go.png"
    "content/gfx/text-p1-won.png"
    "content/gfx/text-p1.png"
    "content/gfx/text-p2-go.png"
    "content/gfx/text-p2-won.png"
    "content/gfx/text-p2.png"
    "content/gfx/yellow-puzzle.png"
    "content/gfx/yellow.png"
    "content/levels/TemplateBase.qml"
    "content/levels/level0.qml"
    "content/levels/level1.qml"
    "content/levels/level2.qml"
    "content/levels/level3.qml"
    "content/levels/level4.qml"
    "content/levels/level5.qml"
    "content/levels/level6.qml"
    "content/levels/level7.qml"
    "content/levels/level8.qml"
    "content/levels/level9.qml"
    "content/qmldir"
    "content/samegame.js"
    "samegame.qml"
)

qt_add_resources(samegame "samegame"
    PREFIX
        "/demos/samegame"
    FILES
        ${samegame_resource_files}
)

install(TARGETS samegame
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
