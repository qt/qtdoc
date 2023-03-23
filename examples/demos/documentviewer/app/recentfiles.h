// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef RECENTFILES_H
#define RECENTFILES_H

#include <QMenu>
#include <QFile>

class QSettings;
class RecentFiles : public QObject, private QStringList
{
    Q_OBJECT
public:
    enum class RemoveReason {
        Reset,
        Dangling,
        TailCut,
        RemovedManually,
        Duplicate
    };
    Q_ENUM(RemoveReason)

    explicit RecentFiles(QObject *parent);

    // Access to QStringList member functions
    qsizetype count() const {return QStringList::count(); };
    const QStringList recentFiles() const {return *this; }
    bool isEmpty() const { return QStringList::isEmpty(); }

    // Properties
    qsizetype maxFiles() const { return m_maxFiles; }
    void setMaxFiles(qsizetype maxFiles) { m_maxFiles = maxFiles; }
    QIODevice::OpenMode openMode() const { return m_openMode; }
    void setOpenMode(QIODevice::OpenMode mode) { m_openMode = mode; }

public slots:
    void addFile(const QString &fileName) {addFile(fileName, EmitPolicy::EmitWhenChanged); }
    void addFiles(const QStringList &fileNames);
    void removeFile(const QString &fileName) {removeFile(indexOf(fileName)); }
    void removeFile(qsizetype index) {removeFile(index, RemoveReason::RemovedManually); }
    void saveSettings(QSettings &settings, const QString &key) const;
    bool restoreFromSettings(QSettings &settings, const QString &key);
    void clear();

signals:
    void fileAdded(const QString &fileName);
    void filesAdded(const QStringList &files);
    void fileRemoved(const QString &fileName, RecentFiles::RemoveReason reason);
    void countChanged(int count);
    void listCleared();
    void settingsRestored(qsizetype count);
    void changed();

private:
    bool testFileAccess(const QString &fileName) const;

    // Private removers with reason
    void removeFile(qsizetype index, RemoveReason reason);
    void removeFile(const QString &fileName, RemoveReason reason) {removeFile(indexOf(fileName), reason); }

    // Private adder with emit policy
    enum class EmitPolicy {
        AllwaysEmit,
        EmitWhenChanged,
        NeverEmit
    };

    void addFile(const QString &fileName, EmitPolicy policy);

    qsizetype m_maxFiles = 10;
    QIODevice::OpenMode m_openMode = QIODevice::ReadOnly;

    // Constexprs for settings
    static constexpr QLatin1StringView s_maxFiles = QLatin1StringView("maxFiles");
    static constexpr QLatin1StringView s_openMode = QLatin1StringView("openMode");
    static constexpr QLatin1StringView s_fileNames = QLatin1StringView("fileNames");
    static constexpr QLatin1StringView s_file = QLatin1StringView("file");
};

#endif // RECENTFILES_H
