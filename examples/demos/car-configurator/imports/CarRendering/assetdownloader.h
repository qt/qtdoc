// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include <QDir>
#include <QNetworkAccessManager>
#include <QtQml/qqmlregistration.h>
#include <QString>
#include <QStringList>
#include <QTemporaryDir>

class AssetDirectory
{
    Q_GADGET

public:
    enum class DirType {
        ApplicationDir,
        UserSpecified,
        Temporary
    };
    Q_ENUM(DirType)

    AssetDirectory(const QString &applicationName);
    ~AssetDirectory();

    QDir dir() const { return m_dir; }
    bool isValid() const { return m_dir.exists() && QFileInfo(m_dir.path()).isWritable(); }

private:
    void init();
    bool pathFromSettings();
    bool pathFromApp();
    bool pathFromTempDir();
    void writeSettings() const;

    DirType m_type = DirType::Temporary;
    QDir m_dir;
    const QString m_appName;
    std::unique_ptr<QTemporaryDir> m_tempDir;
};

class AssetDownloader : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    Q_PROPERTY(int downloadNumber READ downloadNumber NOTIFY downloadStarted)
    Q_PROPERTY(int downloadCount READ downloadCount NOTIFY downloadCountChanged)
    Q_PROPERTY(double progress READ progress NOTIFY downloadProgressChanged)
    Q_PROPERTY(QUrl downloadUrl READ downloadUrl NOTIFY downloadUrlChanged)

public:
    AssetDownloader(QObject *parent = nullptr);

    Q_INVOKABLE void start();
    int downloadCount() const;
    int downloadNumber() const {return m_downloadedCount; }
    double progress() const {return m_progress; }
    QUrl downloadUrl() const;

Q_SIGNALS:
    void finished();
    void downloadStarted(int num);
    void downloadCountChanged(int count);
    void downloadProgressChanged(double progress);
    void downloadUrlChanged(const QUrl &url);

private slots:
    void onDownloadProgressChanged(qint64 bytesReceived, qint64 bytesTotal);
    void onDownloadFinished();

private:
    enum class UnzipRule {
        DeleteArchive,
        KeepArchive
    };
    void startDownload();
    void maybeReadZipFile();
    void readAssetsFile();
    void downloadNextAsset();
    bool unzip(QFile *file, UnzipRule rule);
    QStringList getDownloadList() const;

    QStringList m_downloadPaths;
    QString m_remoteUrl;
    QDir m_baseLocal;
    QStringList m_assetsList;
    int m_downloadedCount = 0;
    double m_progress = 0;
    QNetworkAccessManager m_manager;
    std::unique_ptr<AssetDirectory> m_assetDirectory;
};
