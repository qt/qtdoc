# Copyright (C) 2026 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

from modulefinder import test

import names


def main():
    attachToApplication("fdmaploader")

    if not object.exists(names.close_BasicButton):
        test.passes("Show info button is not visible yet")
    else:
        test.fail("Show info button shouldn't be visible yet, but it is visible")

    mapLoader = findObject(names.mapLoader_Load_Map_BasicButton)
    showInfo = findObject(names.mapLoader_Show_Info_BasicButton)
    changeMap = findObject(names.mapLoader_Change_Map_BasicButton)
    removeMap = findObject(names.mapLoader_Remove_Map_BasicButton)

    #Test initial button states
    test.verify(mapLoader.enabled , "Load Map button should be enabled")
    test.verify(showInfo.enabled, "Show Info button should be enabled")
    test.verify(changeMap.enabled == False, "Change Map button should be disabled")
    test.verify(removeMap.enabled == False, "Remove Map button should be disabled")

    #Test unloaded text popup for show info button
    test.log("Testing unloaded text popup for show info button")
    tapObject(showInfo)
    notLoadedText = str(waitForObject(names.information_not_loaded_Text).text)
    test.verify(notLoadedText, "Popup text should not be empty")
    test.compare(str(waitForObjectExists(names.close_BasicButton).text), "Close")
    tapObject(waitForObject(names.close_BasicButton))

    #Test loading additional map
    test.log("Testing loading loadable map")
    tapObject(mapLoader)
    waitForObject(changeMap)
    test.verify(mapLoader.enabled == False, "Load Map button should be disabled")
    test.verify(showInfo.enabled, "Show Info button should be enabled")
    test.verify(changeMap.enabled, "Change Map button should be enabled")
    test.verify(removeMap.enabled, "Remove Map button should be enabled")

    #Test loaded text popup for show info button
    test.log("Testing loaded text popup for show info button")
    tapObject(showInfo)
    loadedText = str(waitForObject(names.maps_generated_with_AI_Text).text)
    test.verify(loadedText, "Popup text should not be empty")
    test.verify(loadedText != notLoadedText, "Popup text should be different from the one before loading map")

    test.log("Closing info popup")
    tapObject(waitForObject(names.close_BasicButton))

    #Test map change
    test.compare(str(waitForObjectExists(names.mapLoader_image_Image).source.path), "/images/summermap.jpeg")
    test.log("Testing map change")
    tapObject(changeMap)
    test.log("Selecting winter map")
    tapObject(waitForObject(names.qrc_images_wintermap_jpeg_RadioButton))
    test.log("Closing map selection")
    tapObject(names.map_select_close_button)
    test.compare(str(waitForObjectExists(names.mapLoader_image_Image).source.path), "/images/wintermap.jpeg")

    #Test remove map
    test.log("Testing map removal")
    tapObject(removeMap)
    test.verify(mapLoader.enabled, "Load Map button should be enabled")
    test.verify(showInfo.enabled, "Show Info button should be enabled")
    test.verify(changeMap.enabled == False, "Change Map button should be disabled")
    test.verify(removeMap.enabled == False, "Remove Map button should be disabled")
    test.compare(str(waitForObjectExists(names.mapLoader_image_Image).source.path), "/images/summermap.jpeg")

