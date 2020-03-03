TEMPLATE = app

QT += qml quick
android: qtHaveModule(androidextras) {
    QT += androidextras
    DEFINES += REQUEST_PERMISSIONS_ON_ANDROID
}
qtHaveModule(widgets): QT += widgets
SOURCES += main.cpp
RESOURCES += photosurface.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/demos/photosurface
INSTALLS += target
ICON = resources/icon.png
macos: ICON = resources/photosurface.icns
win32: RC_FILE = resources/photosurface.rc

