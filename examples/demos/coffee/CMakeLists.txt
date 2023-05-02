# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(coffee LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

qt_add_executable(coffee
    main.cpp
)

set_target_properties(coffee PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(coffee PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

# Resources:
set(qml_resource_files
    "ApplicationFlow.qml"
    "ApplicationFlowForm.ui.qml"
    "Brewing.qml"
    "BrewingForm.ui.qml"
    "ChoosingCoffee.ui.qml"
    "CoffeeButton.qml"
    "CupForm.ui.qml"
    "EmptyCupForm.ui.qml"
    "NavigationButton.ui.qml"
    "SideBar.qml"
    "SideBarForm.ui.qml"
    "images/cup structure/coffee_cup_large.png"
    "images/cup structure/coffee_cup_outline.png"
    "images/cup structure/cup elements/coffee_cup_back.png"
    "images/cup structure/cup elements/coffee_cup_coverplate.png"
    "images/cup structure/cup elements/coffee_cup_front.png"
    "images/cup structure/liquids/liquid_coffee.png"
    "images/cup structure/liquids/liquid_foam.png"
    "images/cup structure/liquids/liquid_milk.png"
    "images/icons/coffees/Americano.png"
    "images/icons/coffees/Espresso.png"
    "images/icons/coffees/Latte.png"
    "images/icons/coffees/Macchiato.png"
    "images/icons/coffees/cappucino.png"
    "images/icons/contents/coffee.png"
    "images/icons/contents/milk.png"
    "images/icons/contents/sugar.png"
    "images/ui controls/buttons/back/white.png"
    "images/ui controls/buttons/go/white.png"
    "images/ui controls/line.png"
    "imports/Coffee/Constants.qml"
    "imports/Coffee/TitilliumWeb-Regular.ttf"
    "imports/Coffee/qmldir"
    "main.qml"
    "qtquickcontrols2.conf"
)

qt_add_resources(coffee "qml"
    PREFIX
        "/"
    FILES
        ${qml_resource_files}
)

install(TARGETS coffee
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
