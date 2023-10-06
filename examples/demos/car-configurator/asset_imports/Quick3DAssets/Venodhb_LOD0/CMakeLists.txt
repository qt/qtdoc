qt_add_library(Quick3DAssets_Venodhb STATIC)

qt_add_qml_module(Quick3DAssets_Venodhb
    URI "Quick3DAssets.Venodhb_LOD0"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        Venodhb_LOD0.qml
)
