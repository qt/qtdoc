qt_add_library(CarConfiguratorContent STATIC)
qt6_add_qml_module(CarConfiguratorContent
    URI "content"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        App.qml
        CameraReset.qml
        DebugBox.ui.qml
        DoorButton.qml
        doorIcon/Door_button.ui.qml
        doorIcon/Icons.ui.qml
        doorIcon/Logo.ui.qml
        Headlights.ui.qml
        InteriorPointLight.qml
        KissButton.qml
        KissButtonSeparator.qml
        MouseRotatorAndWASD.qml
        PinchWidget.qml
        ScreenPrimary.qml
        WallEffect1/WallEffect1.qml
        WallEffect2/WallEffect2.qml
        WallEffect3/WallEffect3.qml
    RESOURCES
        images/builtWithQt.png
        assets/assets_download.json
)

set(QML_IMPORT_PATH
    ${CMAKE_CURRENT_BINARY_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}/../imports
    ${CMAKE_CURRENT_SOURCE_DIR}/../asset_imports
    CACHE STRING ""
    FORCE
)
