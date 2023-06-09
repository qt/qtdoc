qt_add_library(ComponentBundles_MaterialBundle STATIC)
qt6_add_qml_module(ComponentBundles_MaterialBundle
    URI "ComponentBundles.MaterialBundle"
    VERSION 1.0
    QML_FILES
        AsphaltMaterial.qml
        CopperMaterial.qml
        GoldMaterial.qml
        SilverMaterial.qml
)
