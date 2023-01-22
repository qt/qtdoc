# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

TEMPLATE = app
TARGET = colorpaletteclient

QT += core network qml quick

CONFIG += qmltypes
QML_IMPORT_NAME = ColorPalette
QML_IMPORT_MAJOR_VERSION = 1

SOURCES += main.cpp \
           util.cpp \
           restservice.cpp \
           paginatedresource.cpp \
           basiclogin.cpp \
           restaccessmanager.cpp \

HEADERS += abstractresource.h \
           util.h \
           restservice.h \
           paginatedresource.h \
           basiclogin.h \
           restaccessmanager.h \

qml_resources.files = \
    qmldir \
    MainWindow.qml \

qml_resources.prefix = /qt/qml/ColorPalette

theme_resources.files = \
    icons/colorpaletteclient/index.theme \
    icons/colorpaletteclient/20x20@2/add.png \
    icons/colorpaletteclient/20x20@2/login.png \
    icons/colorpaletteclient/20x20@2/logout.png \
    icons/colorpaletteclient/20x20@2/file_upload.png \
    icons/colorpaletteclient/20x20@2/delete.png \
    icons/colorpaletteclient/20x20@2/edit.png \
    icons/colorpaletteclient/20x20@2/refresh.png \
    icons/colorpaletteclient/20x20@4/add.png \
    icons/colorpaletteclient/20x20@4/login.png \
    icons/colorpaletteclient/20x20@4/logout.png \
    icons/colorpaletteclient/20x20@4/file_upload.png \
    icons/colorpaletteclient/20x20@4/delete.png \
    icons/colorpaletteclient/20x20@4/edit.png \
    icons/colorpaletteclient/20x20@4/refresh.png \
    icons/colorpaletteclient/20x20@3/add.png \
    icons/colorpaletteclient/20x20@3/login.png \
    icons/colorpaletteclient/20x20@3/logout.png \
    icons/colorpaletteclient/20x20@3/file_upload.png \
    icons/colorpaletteclient/20x20@3/delete.png \
    icons/colorpaletteclient/20x20@3/edit.png \
    icons/colorpaletteclient/20x20@3/refresh.png \
    icons/colorpaletteclient/20x20/add.png \
    icons/colorpaletteclient/20x20/login.png \
    icons/colorpaletteclient/20x20/logout.png \
    icons/colorpaletteclient/20x20/file_upload.png \
    icons/colorpaletteclient/20x20/delete.png \
    icons/colorpaletteclient/20x20/edit.png \
    icons/colorpaletteclient/20x20/refresh.png \

theme_resources.prefix = /

RESOURCES += qml_resources theme_resources

target.path = $$[QT_INSTALL_EXAMPLES]/demos/colorpaletteclient
INSTALLS += target
