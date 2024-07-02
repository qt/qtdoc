qt_add_library(CarRenderingMaterialBundle STATIC)

qt_add_qml_module(CarRenderingMaterialBundle
    URI "ComponentBundles.MaterialBundle"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        MirrorMaterial.qml
)
