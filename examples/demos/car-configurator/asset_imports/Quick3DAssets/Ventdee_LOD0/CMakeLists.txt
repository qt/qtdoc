qt_add_library(Quick3DAssets_Ventdee STATIC)

qt_add_qml_module(Quick3DAssets_Ventdee
    URI "Quick3DAssets.Ventdee_LOD0"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        Ventdee_LOD0.qml
)
