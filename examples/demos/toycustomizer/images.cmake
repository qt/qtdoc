# Copyright (C) 2025 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

set(assets_images
    images/appLogo.svg
    images/builtWithQt.svg
    images/dialogBackground.svg
    images/Bear.png
    images/Koala.png
    images/Lion.png
    images/Monkey.png
    images/Cat.png
    images/Deer.png
    images/Panda.png
    images/Pig.png
    images/Sheep.png
    images/Rabbit.png
    images/Raccoon.png
    images/Sloth.png
    images/Squirrel.png
    images/Tiger.png
    images/teddyBear.png
    images/Bear_BaseColor.png
    images/Bear_NormalMap.png
    images/Cat_BaseColor.png
    images/Cat_NormalMap.png
    images/Deer_BaseColor.png
    images/Deer_NormalMap.png
    images/Koala_BaseColor.png
    images/Koala_NormalMap.png
    images/Lion_BaseColor.png
    images/Lion_NormalMap.png
    images/Monkey_BaseColor.png
    images/Monkey_NormalMap.png
    images/Panda_BaseColor.png
    images/Panda_NormalMap.png
    images/Pig_BaseColor.png
    images/Pig_NormalMap.png
    images/Rabbit_BaseColor.png
    images/Rabbit_NormalMap.png
    images/Raccoon_BaseColor.png
    images/Raccoon_NormalMap.png
    images/Sheep_BaseColor.png
    images/Sheep_NormalMap.png
    images/Sloth_BaseColor.png
    images/Sloth_NormalMap.png
    images/Squirrel_BaseColor.png
    images/Squirrel_NormalMap.png
    images/studio_small_01_4k.hdr
    images/Tiger_BaseColor.png
    images/Tiger_NormalMap.png
    images/HeadwearImages/BandanaHatImage1.png
    images/HeadwearImages/BeanieImage1.png
    images/HeadwearImages/CapImage1.png
    images/HeadwearImages/HeadphonesImage1.png
    images/HeadwearImages/PartyHatImage1.png
    images/HeadwearImages/WhiskersImage1.png
    images/HeadwearImages/WizardHatImage1.png
    images/EyewearImages/EyepatchImage1.png
    images/EyewearImages/GlassesImage1.png
    images/EyewearImages/IncognitoImage1.png
    images/EyewearImages/MonacleImage1.png
    images/EyewearImages/NightVisionGogglesImage1.png
    images/EyewearImages/SunglassesImage1.png
    images/EyesImages/AnnoyedEyesImage1.png
    images/EyesImages/ConfusedEyesImage1.png
    images/EyesImages/CuteEyesImage1.png
    images/EyesImages/PowerPuffEyesImage1.png
    images/EyesImages/SmallEyesImage1.png
    images/EyesImages/SurprisedEyesImage1.png
    images/EyesImages/WideEyesImage1.png
    images/ItemsImages/AngelWingsImage1.png
    images/ItemsImages/BackpackImage1.png
    images/ItemsImages/BowtieImage1.png
    images/ItemsImages/BracletsImage1.png
    images/ItemsImages/ButterflyWingsImage1.png
    images/ItemsImages/NecktieImage1.png
    images/Generic_ColorAtlas2_BaseColor.png
    images/Generic_ColorAtlas2_Metallic.png
    images/Generic_ColorAtlas2_Roughness.png
    images/crazyMouth1.png
    images/quteEyes.png
    images/PowerpuffEye.png
    images/wowmouth.png
    images/smallmouth.png
    images/incognito_color.png
    images/BdayHat_BaseColor.png
    images/Wizardhat_BaseColor.png
    images/AngelWings_BaseColor.png
    images/Backpack_BaseColor.png
    images/Butterflywings_BaseColor.png
)

set(assets_icons
    images/icons/back.svg
    images/icons/maximize_circle_fill.svg
    images/icons/headwear.svg
    images/icons/eyewear.svg
    images/icons/eyes.svg
    images/icons/items.svg
    images/icons/names.svg
    images/icons/currency.svg
    images/icons/check.svg
    images/icons/exit.svg
)

# QML code references icons as "icons/<name>.svg" (no "images/" segment), but the files
# live under images/icons/ on disk and share a single qt_target_qml_sources() call (and
# PREFIX) with assets_images below. Set an alias per icon so its resource path drops the
# "images/" segment and matches what the QML files expect.
foreach(icon IN LISTS assets_icons)
    string(REGEX REPLACE "^images/" "" alias "${icon}")
    set_source_files_properties(${icon} PROPERTIES QT_RESOURCE_ALIAS ${alias})
endforeach()

qt_target_qml_sources(${TARGET_NAME}
    PREFIX "/qt/qml/ToyCustomizer/qml/"
    RESOURCES "${assets_images}" "${assets_icons}"
)

set(clean_images "${assets_icons}" "${assets_images}")
list(TRANSFORM clean_images PREPEND "${CMAKE_CURRENT_SOURCE_DIR}/")
set_property(DIRECTORY APPEND PROPERTY ADDITIONAL_CLEAN_FILES ${clean_images})
