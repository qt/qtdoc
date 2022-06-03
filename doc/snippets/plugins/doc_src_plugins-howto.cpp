// Copyright (C) 2016 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

//! [0]
class MyStylePlugin : public QStylePlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QStyleFactoryInterface" FILE "mystyleplugin.json")
public:
    QStyle *create(const QString &key);
};
//! [0]


//! [1]
#include "mystyleplugin.h"

QStyle *MyStylePlugin::create(const QString &key)
{
    if (key.toLower() == "mystyle")
        return new MyStyle;
    return 0;
}

//! [1]


//! [2]
QApplication::setStyle(QStyleFactory::create("MyStyle"));
//! [2]
