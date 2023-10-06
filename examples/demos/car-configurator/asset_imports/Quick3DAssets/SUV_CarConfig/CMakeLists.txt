qt_add_library(Quick3DAssets_SUV STATIC)

qt_add_qml_module(Quick3DAssets_SUV
    URI "Quick3DAssets.SUV_CarConfig"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        Suv_CarConfig.qml
)
