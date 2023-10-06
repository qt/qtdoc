qt_add_library(Quick3DAssets_SUV_NewParts STATIC)

qt_add_qml_module(Quick3DAssets_SUV_NewParts
    URI "Quick3DAssets.SUV_CarConfig_NewParts"
    CLASS_NAME "SUV_NewPartsPlugin" # otherwise default long name can fail build on Windows
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        Suv_CarConfig_NewParts.qml
)
