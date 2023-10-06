qt_add_library(Quick3DAssets_Ulbrbdt STATIC)

qt_add_qml_module(Quick3DAssets_Ulbrbdt
    URI "Quick3DAssets.Ulbrbdt_LOD0"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        Ulbrbdt_LOD0.qml
)
