// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "assetdownloader.h"

#include <QCoreApplication>
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QMetaEnum>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QProcess>
#include <QSettings>

AssetDownloader::AssetDownloader(QObject *parent)
    : QObject(parent)
{
    m_assetDirectory.reset(new AssetDirectory("CarRenderingApp"));
    Q_ASSERT(m_assetDirectory->isValid());
    m_baseLocal = m_assetDirectory->dir();
}

void AssetDownloader::start()
{
    readAssetsFile();
    maybeReadZipFile();
    startDownload();
}

bool AssetDownloader::unzip(QFile *qFile, UnzipRule rule)
{
    const QString fileName = QFileInfo(*qFile).absoluteFilePath();
    QProcess p;
    p.setWorkingDirectory(m_baseLocal.absolutePath());
    p.start("unzip", {fileName});
    if (!p.waitForStarted() || !p.waitForFinished())
        return false;
    const bool success = p.readAllStandardError().isEmpty();
    if (success && rule == UnzipRule::DeleteArchive)
        qFile->remove();
    return success;
}

bool unzipExists()
{
    QProcess p;
    p.start("unzip");
    if (!p.waitForStarted() || !p.waitForFinished())
        return false;
    const QByteArray error = p.readAllStandardError();
    return error.isEmpty();
}

static constexpr QLatin1StringView downloadBase("https://download.qt.io/learning/examples/");
void AssetDownloader::maybeReadZipFile()
{
    if (!downloadCount() || !unzipExists())
        return;

    static constexpr QLatin1StringView zipFileName("car-configurator-assets-v1.zip");

    QFile zipFile(m_baseLocal.absoluteFilePath(zipFileName));
    const QUrl url = QUrl(downloadBase + zipFileName);
    QNetworkRequest request(url);
    QEventLoop loop;
    QNetworkReply *reply = m_manager.get(request);
    connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    connect(reply, &QNetworkReply::downloadProgress,
            this, &AssetDownloader::onDownloadProgressChanged);
    loop.exec();

    if (reply->error() != QNetworkReply::NoError || !zipFile.open(QIODevice::WriteOnly))
        return;
    zipFile.write(reply->readAll());
    zipFile.close();
    unzip(&zipFile, UnzipRule::DeleteArchive);

    // Update missing files
    m_downloadPaths = getDownloadList();
}

void AssetDownloader::readAssetsFile()
{
    static constexpr QLatin1StringView resourcePath(":/qt/qml/assets/assets_download.json");
    static constexpr QLatin1StringView jsonFileName("car-configurator-assets-v1.json");
    const QUrl url(downloadBase + jsonFileName);
    QNetworkRequest request(url);
    QNetworkReply *reply = m_manager.get(request);
    QEventLoop loop;
    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    loop.exec();
    QByteArray array;
    if (reply->error() == QNetworkReply::NoError) {
        array = reply->readAll();
    } else {
        QFile file(resourcePath);
        if (!file.open(QIODevice::ReadOnly)) {
            qWarning() << "Failed to open" << resourcePath;
            return;
        }
        array = file.readAll();
    }

    QJsonObject json = QJsonDocument::fromJson(array).object();

    const QJsonArray assetsArray = json["assets"].toArray();
    for (const QJsonValue &asset : assetsArray)
        m_assetsList.append(asset.toString());

    m_remoteUrl = json["url"].toString();

    Q_ASSERT(!m_assetsList.isEmpty() && !m_remoteUrl.isEmpty());
    m_downloadPaths = getDownloadList();
}

void AssetDownloader::startDownload()
{
    m_downloadedCount = 0;

    if (m_downloadPaths.size() > 0)
        emit downloadCountChanged(downloadCount());

    if (m_remoteUrl.isEmpty() || m_downloadPaths.isEmpty()) {
        // downloadUrl can be read already after construction.
        // We notify only, when it is fully populated.
        emit downloadUrlChanged(downloadUrl());
        emit finished();
    } else {
        downloadNextAsset();
    }
}

void AssetDownloader::downloadNextAsset()
{
    if (m_downloadedCount < m_downloadPaths.size()) {
        emit downloadStarted(m_downloadedCount + 1);

        const QString &assetUrl = m_downloadPaths[m_downloadedCount];

        const QUrl url = QUrl(m_remoteUrl).resolved(assetUrl);
        QNetworkRequest request(url);

        QNetworkReply *reply = m_manager.get(request);

        connect(reply, &QNetworkReply::finished, this, &AssetDownloader::onDownloadFinished);
        connect(reply, &QNetworkReply::downloadProgress,
                this, &AssetDownloader::onDownloadProgressChanged);
    }
}

// Get the list of files to download (exclude the ones that are already downloaded)
QStringList AssetDownloader::getDownloadList() const
{
    QStringList downloadList;
    std::copy_if(m_assetsList.begin(), m_assetsList.end(), std::back_inserter(downloadList),
                 [&](const QString &imgPath) {
        const QString localPath = QDir(m_baseLocal.path()).absoluteFilePath(imgPath);
        return !QFileInfo::exists(localPath);
    });

    return downloadList;
}

int AssetDownloader::downloadCount() const
{
    return m_downloadPaths.size();
}

QUrl AssetDownloader::downloadUrl() const
{
    return QUrl::fromLocalFile(m_baseLocal.absolutePath());
}

void AssetDownloader::onDownloadProgressChanged(qint64 bytesReceived, qint64 bytesTotal)
{
    const double progress = static_cast<double>(bytesReceived) / static_cast<double>(bytesTotal);
    if (progress == m_progress)
        return;

    emit downloadProgressChanged(progress);
}

void AssetDownloader::onDownloadFinished()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    reply->deleteLater();

    if (reply->error() == QNetworkReply::NoError) {
        QByteArray assetData = reply->readAll();

        QFileInfo fi(QDir(m_baseLocal.path()).absoluteFilePath(m_downloadPaths[m_downloadedCount]));
        QDir dir (fi.path());
        if (!dir.exists()) {
            if (!dir.mkpath("."))
                qWarning() << "Failed to create save path:" << fi.path();
        }
        QFile file(fi.filePath());
        if (file.open(QIODevice::WriteOnly)) {
            file.write(assetData);
            file.close();
        } else {
            qWarning() << "Failed to save asset:" << file.errorString();
        }
    } else {
        qWarning() << "Download failed:" << reply->errorString();
    }

    ++m_downloadedCount;

    if (m_downloadedCount == m_downloadPaths.size())
        emit finished();
    else
        downloadNextAsset();
}

AssetDirectory::AssetDirectory(const QString &applicationName)
    : m_appName(applicationName)
{
    init();
}

AssetDirectory::~AssetDirectory()
{
    writeSettings();
}

void AssetDirectory::init()
{
    if (pathFromSettings() || pathFromApp())
        return;
    pathFromTempDir();
}

static constexpr QLatin1StringView s_organisation("The Qt Company");
static constexpr QLatin1StringView s_dir("assetDirectory");
static constexpr QLatin1StringView s_type("directoryType");

bool AssetDirectory::pathFromSettings()
{
    const QSettings settings(s_organisation, m_appName);
    if (!settings.contains(s_dir))
        return false;
    const QString dirName = settings.value(s_dir).toString();
    const QDir dir(dirName);
    if (!dir.exists())
        return false;

    m_dir = dir;

    const QString typeKey = settings.value(s_type).toString();
    bool ok;
    int type = QMetaEnum::fromType<DirType>().keyToValue(typeKey.toLatin1().constData(), &ok);
    m_type = ok ? static_cast<DirType>(type) : DirType::UserSpecified;
    return true;
}

bool AssetDirectory::pathFromApp()
{
    QDir appDir = QCoreApplication::applicationDirPath();
    if (!QFileInfo(appDir.path()).isWritable())
        return false;

    m_type = DirType::ApplicationDir;
    m_dir = appDir;
    return true;
}

bool AssetDirectory::pathFromTempDir()
{
    m_tempDir.reset(new QTemporaryDir);
    Q_ASSERT_X(m_tempDir->isValid(), "QTemporaryDir", "No writable path for graphical assets found.");
    m_dir = QDir(m_tempDir->path());
    m_type = DirType::Temporary;
    qWarning() << QObject::tr("Assets will be downloaded to a temprary directory and deleted when the application is closed.");
    return true;
}

void AssetDirectory::writeSettings() const
{
    QSettings settings(s_organisation, m_appName);
    if (m_type == DirType::Temporary) {
        settings.remove(s_dir);
        settings.remove(s_type);
    } else {
        settings.setValue(s_dir, QFileInfo(m_dir.path()).absoluteFilePath());
        settings.setValue(s_type, QMetaEnum::fromType<DirType>().valueToKey(static_cast<int>(m_type)));
    }

    settings.sync();
}
