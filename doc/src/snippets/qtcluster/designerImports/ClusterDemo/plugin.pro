CXX_MODULE = qml
TARGET  = clusterdemo
QT += qml quick
TEMPLATE = lib
CONFIG -= debug
CONFIG += release
DESTDIR  = $$PWD
TARGET = $$qtLibraryTarget($$TARGET)

OUT_PWD = $$PWD

SOURCES += \
    plugin.cpp \
    ../../etcprovider.cpp \
    ../../circularindicator.cpp \
    ../../gauge.cpp \
    ../../gaugenode.cpp

HEADERS += \
        ../../etcprovider.h \
        ../../circularindicator.h \
        ../../gauge.h \
        ../../gaugenode.h

RESOURCES += plugin.qrc \
    ../../images.qrc \
    ../../sportsimages.qrc \
    ../../hybridimages.qrc


DISTFILES = qmldir

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

