// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "recentfiles.h"
#include <QFileInfo>
#include <QSettings>

void RecentFiles::clear()
{
    if (isEmpty())
        return;

    QStringList::clear();
    emit countChanged(0);
    emit listCleared();
}

void RecentFiles::addFile(const QString &fileName, EmitPolicy policy)
{
    if (!testFileAccess(fileName))
        return;

    // Remember size, as cleanup can result in a change without size change
    const qsizetype c = count();

    // Clean dangling and duplicate files
    bool duplicateFound = false;
    for (const QString &file : *this) {
        if (!testFileAccess(file)) {
            removeFile(file, RemoveReason::Dangling);
        } else if (file == fileName) {
            removeFile(file, RemoveReason::Duplicate);
            duplicateFound = true;
        }
    }

    // Cut tail
    while (count() > m_maxFiles)
        removeFile((count() - 1), RemoveReason::TailCut);

    prepend(fileName);

    switch (policy) {
    case EmitPolicy::NeverEmit:
        return;

    case EmitPolicy::AllwaysEmit:
        emit changed();
        emit fileAdded(fileName);
        emit countChanged(count());
        return;

    case EmitPolicy::EmitWhenChanged:
        emit changed();
        if (!duplicateFound)
            emit fileAdded(fileName);

        if (c != count())
            emit countChanged(count());

        return;
    }
}

void RecentFiles::addFiles(const QStringList &files)
{
    if (files.isEmpty())
        return;

    if (files.count() == 1) {
        addFile(files.at(0));
        return;
    }

    const auto &c = count();

    for (const auto &file : files)
        addFile(file, EmitPolicy::NeverEmit);

    emit filesAdded(files);
    emit changed();
    if (count() != c)
        emit countChanged(count());
}

// Test if file exists and can be opened
bool RecentFiles::testFileAccess(const QString &fileName) const
{
    QFileInfo info(fileName);
    if (!info.isFile())
        return false;

    switch (m_openMode) {
    case QIODevice::ReadOnly:
        if (!info.isReadable())
            return false;
        break;
    case QIODevice::ReadWrite:
        if (!(info.isReadable() && info.isWritable()))
            return false;
        break;
    case QIODevice::WriteOnly:
        if (!info.isWritable())
            return false;
        break;
    }
    return true;
}

void RecentFiles::removeFile(qsizetype index, RemoveReason reason)
{
    if (index < 0 || index >= count())
        return;

    const QString &fileName = at(index);
    remove(index);

    // No emit for duplicate removal, add emits changed later.
    if (reason == RemoveReason::Duplicate)
        return;

    emit fileRemoved(fileName, reason);
    emit changed();
}

void RecentFiles::saveSettings(QSettings &settings, const QString &key) const
{
    settings.beginGroup(key);
    settings.setValue(s_maxFiles, maxFiles());
    settings.setValue(s_openMode, static_cast<int>(openMode()));
    if (!isEmpty()) {
        settings.beginWriteArray(s_fileNames, count());
        for (int index = 0; index < count(); ++index) {
            settings.setArrayIndex(index);
            settings.setValue(s_file, at(index));
        }
        settings.endArray();
    }
    settings.endGroup();
}

bool RecentFiles::restoreFromSettings(QSettings &settings, const QString &key)
{
    settings.beginGroup(key);
    const qsizetype mxFiles = settings.value(s_maxFiles, maxFiles()).toLongLong();
    const auto mode = qvariant_cast<QIODevice::OpenMode>(settings.value(s_openMode,
                                             static_cast<int>(openMode())).toInt());
    setMaxFiles(mxFiles);
    setOpenMode(mode);
    QStringList::clear(); // clear list without emitting
    const int numberFiles = settings.beginReadArray(s_fileNames);
    for (int index = 0; index < numberFiles; ++index) {
        settings.setArrayIndex(index);
        const QString absoluteFilePath = settings.value(s_file).toString();
        addFile(absoluteFilePath, EmitPolicy::NeverEmit);
    }
    settings.endArray();
    settings.endGroup();
    if (count() > 0) {
        emit settingsRestored(count());
        emit changed();
    }

    return true;
}
