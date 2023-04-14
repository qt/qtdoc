find_package(Qt6 REQUIRED COMPONENTS Gui)

qt_add_qml_module(backendmodule
    URI Backend
    VERSION 1.0
    SOURCES
        animatedparam.cpp
        animatedparam.h
        backend.cpp
        backend.h
    RESOURCE_PREFIX "/"
)

target_link_libraries(backendmodule PUBLIC Qt6::Gui)
