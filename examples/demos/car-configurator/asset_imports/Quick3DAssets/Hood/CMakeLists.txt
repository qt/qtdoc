qt_add_library(Quick3DAssets_Hood STATIC)

qt_add_qml_module(Quick3DAssets_Hood
    URI "Quick3DAssets.Hood"
    CLASS_NAME "HoodPlugin"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        Hood.qml
)
