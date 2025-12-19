# Copyright (C) 2026 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

from objectmaphelper import *

mapLoader_QQuickWindowQmlImpl = {"title": "MapLoader", "type": "QQuickWindowQmlImpl"}
mapLoader_Load_Map_BasicButton = {"container": mapLoader_QQuickWindowQmlImpl, "id": "loadMapButton", "text": "Load Map", "type": "BasicButton"}
mapLoader_Show_Info_BasicButton = {"container": mapLoader_QQuickWindowQmlImpl, "id": "showMapInfoButton", "text": "Show Info", "type": "BasicButton"}
mapLoader_Overlay = {"container": mapLoader_QQuickWindowQmlImpl, "type": "Overlay"}
close_BasicButton = {"container": mapLoader_Overlay, "id": "mapInfoPopupOkButton", "text": "Close", "type": "BasicButton"}
maps_generated_with_AI_Text = {"container": mapLoader_Overlay, "text": "Maps generated with AI", "type": "Text"}
information_not_loaded_Text = {"container": mapLoader_Overlay, "text": "Information not loaded", "type": "Text"}
mapLoader_image_Image = {"container": mapLoader_QQuickWindowQmlImpl, "id": "image", "type": "Image"}
mapLoader_Change_Map_BasicButton = {"container": mapLoader_QQuickWindowQmlImpl, "id": "changeMapButton", "text": "Change Map", "type": "BasicButton"}
qrc_images_wintermap_jpeg_RadioButton = {"container": mapLoader_Overlay, "text": "qrc:/images/wintermap.jpeg", "type": "RadioButton"}
map_select_close_button = {"container": mapLoader_Overlay, "id": "okButton", "text": "Close", "type": "BasicButton"}
qrc_images_summermap_jpeg_RadioButton = { "container": mapLoader_Overlay, "text": "qrc:/images/summermap.jpeg", "type": "RadioButton"}
mapLoader_Remove_Map_BasicButton = {"container": mapLoader_QQuickWindowQmlImpl, "id": "removeMapButton", "text": "Remove Map", "type": "BasicButton"}
