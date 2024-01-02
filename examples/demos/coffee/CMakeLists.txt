# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(coffee LANGUAGES CXX)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)
qt_standard_project_setup(REQUIRES 6.6)

qt_add_executable(coffeemachine
    main.cpp
)

set_source_files_properties(Colors.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(coffeemachine
    URI demos.coffee
    QML_FILES
        ApplicationFlow.qml
        ApplicationFlowForm.ui.qml
        ChoosingCoffee.qml
        CoffeeCard.qml
        Colors.qml
        CustomButton.qml
        CustomSlider.qml
        CustomToolBar.qml
        Cup.qml
        Home.qml
        Insert.qml
        main.qml
        Progress.qml
        Ready.qml
        Settings.qml
    RESOURCES
        qtquickcontrols2.conf
        images/Cups/card_cup_dark.svg
        images/Cups/card_cup_light.svg
        images/Cups/dark_cup.svgz
        images/Cups/home_dark.svg
        images/Cups/home_light.svg
        images/Cups/light_cup.svgz
        images/icons/check.svg
        images/icons/dark_mode_black_24dp.svg
        images/icons/ellipse_dark.svg
        images/icons/ellipse_light.svg
        images/icons/keyboard_backspace_black.svg
        images/icons/keyboard_backspace_black_left.svg
        images/icons/keyboard_backspace_black_right.svg
        images/icons/keyboard_backspace_white_left.svg
        images/icons/keyboard_backspace_white_right.svg
        images/icons/light_mode_black_24dp.svg
        images/icons/Polygon.svg
        images/icons/Qt-logo-white-transparent.svg
        images/Ingredients/espresso_coffee.svg
        images/Ingredients/Milk_foam.svg
        images/Ingredients/milk.svg
        images/Ingredients/sugar.svg
)

set_target_properties(coffeemachine PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(coffeemachine PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

install(TARGETS coffeemachine
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
