qt_add_library(Quick3DAssets_InteriorShadow STATIC)

qt_add_qml_module(Quick3DAssets_InteriorShadow
    URI "Quick3DAssets.InteriorShadow"
    CLASS_NAME "InteriorShadowPlugin"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        InteriorShadow.qml
)
