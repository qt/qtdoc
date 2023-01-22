// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef UTIL_H
#define UTIL_H

#include <QtCore/qjsonobject.h>

std::optional<QJsonObject> byteArrayToJsonObject(const QByteArray& data);

#endif // UTIL_H
