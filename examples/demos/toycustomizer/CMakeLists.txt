# Copyright (C) 2025 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

cmake_minimum_required(VERSION 3.16)

project(ToyCustomizer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_WASM_INITIAL_MEMORY "200MB")

find_package(Qt6 REQUIRED COMPONENTS Quick ShaderTools)

qt_standard_project_setup(REQUIRES 6.10)

set(qml_singletons
    qml/ApplicationConfig.qml
    qml/ToyModel.qml
    qml/AccessoryState.qml
)
set_source_files_properties(${qml_singletons} PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

set(TARGET_NAME toycustomizer)
qt_add_executable(${TARGET_NAME}
    main.cpp
)

qt_add_resources(${TARGET_NAME} "fonts"
    FILES
        fonts/WinkySans/WinkySans-VariableFont_wght.ttf
        fonts/WinkySans/WinkySans-Italic-VariableFont_wght.ttf
        fonts/DynaPuff/DynaPuff-VariableFont_wdth,wght.ttf
)

qt_add_qml_module(${TARGET_NAME}
    URI ToyCustomizer
    VERSION 1.0
    QML_FILES
        ${qml_singletons}
        qml/AccessoryMaterialLibrary.qml
        qml/AccessoryModel.qml
        qml/AnimationMaterial.qml
        qml/AnimationModel.qml
        qml/GalleryViewDelegate.qml
        qml/Main.qml
        qml/MainPage.qml
        qml/PageStepper.qml
        qml/ShowcaseView.qml
        qml/ToyAnimations.qml
        qml/ToyButton.qml
        qml/ToyConfirmPage.qml
        qml/ToyCustom.qml
        qml/ToyGalleryPage.qml
        qml/ToyHeader.qml
        qml/ToyImage.qml
        qml/ToyLabel.qml
        qml/OverViewPage.qml
        qml/OrderGrid.qml
        qml/OrderItem.qml
        qml/ToyCustomizePage.qml
        qml/ToyView.qml
        qml/MaximizeView.qml
        qml/AccessoryView.qml
        qml/AccessoryState.qml
        qml/CustomizationCard.qml
        qml/NameTumbler.qml
        qml/ColorButton.qml
        qml/BearCustom.qml
        qml/CatCustom.qml
        qml/DeerCustom.qml
        qml/SheepCustom.qml
        qml/LionCustom.qml
        qml/RaccoonCustom.qml
        qml/SquirrelCustom.qml
        qml/MonkeyCustom.qml
        qml/PandaCustom.qml
        qml/KoalaCustom.qml
        qml/SlothCustom.qml
        qml/TigerCustom.qml
        qml/RabbitCustom.qml
        qml/PigCustom.qml
        qml/CurrentToyModel.qml
        qml/OrbitCameraController.qml
        # TODO: add the other qml files
)

qt_add_shaders(${TARGET_NAME} "shaders"
    GLSL
    PREFIX "/qt/qml/ToyCustomizer/"
    FILES
        qml/shaders/buttonpressedshadow.frag
        qml/shaders/buttonpressedshadow.vert
        qml/shaders/coloroverlay.frag
)

add_subdirectory(images)
add_subdirectory(animations)
add_subdirectory(meshes)

add_subdirectory(assets)
add_dependencies(${TARGET_NAME} assets_complete)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(${TARGET_NAME} PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.${TARGET_NAME}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(${TARGET_NAME}
    PRIVATE
        Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS ${TARGET_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
