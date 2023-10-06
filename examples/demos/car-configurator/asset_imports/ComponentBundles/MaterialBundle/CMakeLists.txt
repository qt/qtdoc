qt_add_library(CarRenderingMaterialBundle STATIC)

qt_add_qml_module(CarRenderingMaterialBundle
    URI "ComponentBundles.MaterialBundle"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        CarPaintMaterial.qml
    RESOURCES
        images/LDR_RGB1_3.png
        shaders/carmat_simple_nf.frag
        shaders/carmat_simple_nf.vert
)
