/****************************************************************************
**
** Copyright (C) 2020 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "xmllistmodel.h"

#include <QQmlFile>
#include <QFile>
#include <QCoreApplication>
#include <QMutexLocker>

Q_DECLARE_METATYPE(XmlListModelQueryResult)

QHash<QQmlEngine *, XmlListModelQueryEngine*> XmlListModelQueryEngine::queryEngines;
QMutex XmlListModelQueryEngine::queryEnginesMutex;

XmlListModelQueryThreadObject::XmlListModelQueryThreadObject(XmlListModelQueryEngine *e)
    : m_queryEngine(e)
{
}

void XmlListModelQueryThreadObject::processJobs()
{
    QCoreApplication::postEvent(this, new QEvent(QEvent::User));
}

bool XmlListModelQueryThreadObject::event(QEvent *e)
{
    if (e->type() == QEvent::User) {
        m_queryEngine->processJobs();
        return true;
    }
    return QObject::event(e);
}

XmlListModelQueryEngine::XmlListModelQueryEngine(QQmlEngine *eng)
: QThread(eng), m_threadObject(nullptr), m_queryIds(1), m_engine(eng), m_eventLoopQuitHack(nullptr)
{
    qRegisterMetaType<XmlListModelQueryResult>("XmlListModelQueryResult");

    m_eventLoopQuitHack = new QObject;
    m_eventLoopQuitHack->moveToThread(this);

    connect(m_eventLoopQuitHack, &QObject::destroyed,
        this, &QThread::quit, Qt::DirectConnection);
    start(QThread::IdlePriority);
}

XmlListModelQueryEngine::~XmlListModelQueryEngine()
{
    queryEnginesMutex.lock();
    queryEngines.remove(m_engine);
    queryEnginesMutex.unlock();

    m_eventLoopQuitHack->deleteLater();
    wait();
}

void XmlListModelQueryEngine::abort(int id)
{
    QMutexLocker ml(&m_mutex);
    if (id != -1)
        m_cancelledJobs.insert(id);
}

void XmlListModelQueryEngine::run()
{
    m_mutex.lock();
    m_threadObject = new XmlListModelQueryThreadObject(this);
    m_mutex.unlock();

    processJobs();
    exec();

    delete m_threadObject;
    m_threadObject = nullptr;
}

XmlListModelQueryEngine *XmlListModelQueryEngine::instance(QQmlEngine *engine)
{
    QMutexLocker ml(&queryEnginesMutex);
    XmlListModelQueryEngine *queryEng = queryEngines.value(engine);
    if (!queryEng) {
        queryEng = new XmlListModelQueryEngine(engine);
        queryEngines.insert(engine, queryEng);
    }

    return queryEng;
}

int XmlListModelQueryEngine::doQuery(QString query, QByteArray data, QList<XmlListModelRole *>* roles)
{
    {
        QMutexLocker m1(&m_mutex);
        m_queryIds.ref();
        if (m_queryIds.loadRelaxed() <= 0)
            m_queryIds.storeRelaxed(1);
    }

    XmlListModelQueryJob job;
    job.queryId = m_queryIds.loadRelaxed();
    job.data = data;
    job.query = query;

    for (int i = 0; i < roles->count(); i++) {
        if (!roles->at(i)->isValid()) {
            job.roleNames << QString();
            job.roleQueries << QString();
            continue;
        }
        job.roleNames << roles->at(i)->elementName();
        job.roleQueries << roles->at(i)->attributeName();
        job.roleQueryErrorId << static_cast<void*>(roles->at(i));
    }

    {
        QMutexLocker ml(&m_mutex);
        m_jobs.append(job);
        if (m_threadObject)
            m_threadObject->processJobs();
    }

    return job.queryId;
}

void XmlListModelQueryEngine::processJobs()
{
    QMutexLocker locker(&m_mutex);

    while (true) {
        if (m_jobs.isEmpty())
            return;

        XmlListModelQueryJob currentJob = m_jobs.takeLast();
        while (m_cancelledJobs.remove(currentJob.queryId)) {
            if (m_jobs.isEmpty())
              return;
            currentJob = m_jobs.takeLast();
        }

        locker.unlock();
        processQuery(&currentJob);
        locker.relock();
    }
}

void XmlListModelQueryEngine::processQuery(XmlListModelQueryJob *job)
{
    XmlListModelQueryResult result;
    result.queryId = job->queryId;
    doQueryJob(job, &result);

    QMutexLocker ml(&m_mutex);
    if (m_cancelledJobs.contains(job->queryId)) {
        m_cancelledJobs.remove(job->queryId);
    } else {
        ml.unlock();
        Q_EMIT queryCompleted(result);
    }
}

void XmlListModelQueryEngine::doQueryJob(XmlListModelQueryJob *currentJob, XmlListModelQueryResult *currentResult)
{
    Q_ASSERT(currentJob->queryId != -1);

    QByteArray data(currentJob->data);
    QXmlStreamReader reader;
    reader.addData(data);

    QStringList items = currentJob->query.split(QLatin1Char('/'), Qt::SkipEmptyParts);

    while (!reader.atEnd()) {
        int i = 0;
        while (i < items.count()) {
            if (reader.readNextStartElement()) {
                if (reader.name() == items.at(i)) {
                    if (i != items.count() - 1) {
                        i++;
                        continue;
                    } else {
                        processElement(currentJob, currentResult, items.at(i), reader);
                    }
                } else {
                    reader.skipCurrentElement();
                }
            }
            if (reader.tokenType() == QXmlStreamReader::Invalid) {
                reader.readNext();
                break;
            }
            else if (reader.hasError()) {
                reader.raiseError();
                break;
            }
        }
    }
}

void XmlListModelQueryEngine::processElement(XmlListModelQueryJob *currentJob, XmlListModelQueryResult*& currentResult, QString element, QXmlStreamReader &reader)
{
    if (!reader.isStartElement() || reader.name() != element)
        return;

    const QStringList &roleQueries = currentJob->roleQueries;
    const QStringList &roleNames = currentJob->roleNames;
    QHash<int, QString> resultList;


    while (reader.readNextStartElement()) {

        if (roleNames.contains(reader.name()) && !reader.name().isEmpty()) {
            bool hasLink = false;
            bool hasJpegImageLink = false;

            QString roleResult;
            const int index = roleNames.indexOf(reader.name());

            if (!roleQueries.at(index).isEmpty()) {
                if (reader.attributes().hasAttribute(roleQueries.at(index))) {
                    if (roleQueries.at(index) == "href") {
                        hasLink = true;
                        if (reader.attributes().value("type").toString() == "image/jpeg")
                            hasJpegImageLink = true;
                    }
                    roleResult = reader.attributes().value(roleQueries.at(index)).toString();
                } else {
                    Q_EMIT error(currentJob->roleQueryErrorId.at(index), roleQueries[index]);
                }
            } else if (!roleNames.at(index).isEmpty()) {
                roleResult = reader.readElementText();
            }

            if (hasLink && !hasJpegImageLink)
                reader.skipCurrentElement();
            else
                resultList[index] = roleResult;

        } else {
            reader.skipCurrentElement();
        }
    }

    if (resultList.count() <= 0)
        resultList = QHash<int, QString>();
    currentResult->data << resultList;
}

QString XmlListModelRole::elementName() const { return m_elementName; }

void XmlListModelRole::setElementName(const QString &name)
{
    if (name == m_elementName)
        return;
    m_elementName = name;
    Q_EMIT elementNameChanged();
}

QString XmlListModelRole::attributeName() const { return m_attributeName; }

void XmlListModelRole::setAttributeName(const QString &attributeName)
{
    if (m_attributeName == attributeName)
        return;
    m_attributeName = attributeName;
    Q_EMIT attributeNameChanged();
}

bool XmlListModelRole::isValid() const
{
    return !m_elementName.isEmpty();
}

XmlListModel::XmlListModel(QObject *parent) : QAbstractListModel(parent)
    , m_isComponentComplete(true), m_size(0), m_highestRole(Qt::UserRole)
#if QT_CONFIG(qml_network)
    , m_reply(nullptr)
#endif
    , m_status(XmlListModel::Null), m_progress(0.0)
    , m_queryId(-1), m_roleObjects(), m_redirectCount(0)
{
}

QModelIndex XmlListModel::index(int row, int column, const QModelIndex &parent) const
{
    return !parent.isValid() && column == 0 && row >= 0 && m_size
            ? createIndex(row, column)
            : QModelIndex();
}

int XmlListModel::rowCount(const QModelIndex &parent) const
{
    return !parent.isValid() ? m_size : 0;
}

QVariant XmlListModel::data(const QModelIndex &index, int role) const
{
    const int roleIndex = m_roles.indexOf(role);
    return (roleIndex == -1 || !index.isValid())
            ? QVariant()
            : m_data.value(index.row()).value(roleIndex);
}

QHash<int, QByteArray> XmlListModel::roleNames() const
{
    QHash<int,QByteArray> roleNames;
    for (int i = 0; i < m_roles.count(); ++i)
        roleNames.insert(m_roles.at(i), m_roleNames.at(i).toUtf8());
    return roleNames;
}

int XmlListModel::count() const
{
    return m_size;
}

QUrl XmlListModel::source() const
{
    return m_source;
}

void XmlListModel::setSource(const QUrl &src)
{
    if (m_source != src) {
        m_source = src;
        reload();
        Q_EMIT sourceChanged();
    }
}

QString XmlListModel::query() const
{
    return m_query;
}

void XmlListModel::setQuery(const QString &query)
{
    if (!query.startsWith(QLatin1Char('/'))) {
        qmlWarning(this) << QCoreApplication::translate("XmlListModelRoleList", "An XmlListModel query must start with '/'");
        return;
    }

    if (m_query != query) {
        m_query = query;
        reload();
        Q_EMIT queryChanged();
    }
}

QQmlListProperty<XmlListModelRole> XmlListModel::roleObjects()
{
    QQmlListProperty<XmlListModelRole> list(this, &m_roleObjects);
    list.append = &XmlListModel::appendRole;
    list.clear = &XmlListModel::clearRole;
    return list;
}

void XmlListModel::appendRole(XmlListModelRole* role)
{
    int i = m_roleObjects.count();
    m_roleObjects.append(role);
    if (m_roleNames.contains(role->elementName())) {
        qmlWarning(role) << XmlListModel::tr("\"%1\" duplicates a previous role name and will be disabled.").arg(role->elementName());
        return;
    }
    m_roles.insert(i, m_highestRole);
    m_roleNames.insert(i, role->elementName());
    ++m_highestRole;
}

void XmlListModel::clearRole()
{
    m_roles.clear();
    m_roleNames.clear();
    m_roleObjects.clear();
}

void XmlListModel::appendRole(QQmlListProperty<XmlListModelRole>* list, XmlListModelRole* role)
{
    reinterpret_cast<XmlListModel*>(list->object)->appendRole(role);
}

void XmlListModel::clearRole(QQmlListProperty<XmlListModelRole>* list)
{
    reinterpret_cast<XmlListModel*>(list->object)->clearRole();
}

XmlListModel::Status XmlListModel::status() const
{
    return m_status;
}

qreal XmlListModel::progress() const
{
    return m_progress;
}

QString XmlListModel::errorString() const
{
    return m_errorString;
}

void XmlListModel::classBegin()
{
    m_isComponentComplete = false;

    XmlListModelQueryEngine *queryEngine = XmlListModelQueryEngine::instance(qmlEngine(this));
    connect(queryEngine, &XmlListModelQueryEngine::queryCompleted,
        this, &XmlListModel::queryCompleted);
    connect(queryEngine, &XmlListModelQueryEngine::error,
        this, &XmlListModel::queryError);
}

void XmlListModel::componentComplete()
{
    m_isComponentComplete = true;
    reload();
}

void XmlListModel::reload()
{
    if (!m_isComponentComplete)
        return;

    XmlListModelQueryEngine::instance(qmlEngine(this))->abort(m_queryId);
    m_queryId = -1;

    if (m_size < 0)
        m_size = 0;

#if QT_CONFIG(qml_network)
    if (m_reply) {
        m_reply->abort();
        deleteReply();
    }
#endif

    if (m_source.isEmpty()) {
        m_queryId = 0;
        notifyQueryStarted(false);
        QTimer::singleShot(0, this, &XmlListModel::dataCleared);
    }
    else if (QQmlFile::isLocalFile(m_source)) {
        QFile file(QQmlFile::urlToLocalFileOrQrc(m_source));
        QByteArray data = file.open(QIODevice::ReadOnly) ? file.readAll() : QByteArray();
        notifyQueryStarted(false);
        if (data.isEmpty()) {
            m_queryId = 0;
            QTimer::singleShot(0, this, &XmlListModel::dataCleared);
        } else {
            m_queryId = XmlListModelQueryEngine::instance(qmlEngine(this))->doQuery(
                m_query, data, &m_roleObjects);
        }
    } else {
#if QT_CONFIG(qml_network)
        notifyQueryStarted(true);
        QNetworkRequest req(m_source);
        req.setRawHeader("Accept", "application/xml,*/*");
        m_reply = qmlContext(this)->engine()->networkAccessManager()->get(req);

        QObject::connect(m_reply, &QNetworkReply::finished,
            this, &XmlListModel::requestFinished);
        QObject::connect(m_reply, &QNetworkReply::downloadProgress,
            this, &XmlListModel::requestProgress);
#else
        m_queryId = 0;
        notifyQueryStarted(false);
        QTimer::singleShot(0, this, &XmlListModel::dataCleared);
#endif
    }
}

#define XMLLISTMODEL_MAX_REDIRECT 16

#if QT_CONFIG(qml_network)
void XmlListModel::requestFinished()
{
    m_redirectCount++;
    if (m_redirectCount < XMLLISTMODEL_MAX_REDIRECT) {
        QVariant redirect = m_reply->attribute(QNetworkRequest::RedirectionTargetAttribute);
        if (redirect.isValid()) {
            QUrl url = m_reply->url().resolved(redirect.toUrl());
            deleteReply();
            setSource(url);
            return;
        }
    }
    m_redirectCount = 0;

    if (m_reply->error() != QNetworkReply::NoError) {
        m_errorString = m_reply->errorString();
        deleteReply();

        if (m_size > 0) {
            beginRemoveRows(QModelIndex(), 0, m_size - 1);
            m_data.clear();
            m_size = 0;
            endRemoveRows();
            Q_EMIT countChanged();
        }

        m_status = Error;
        m_queryId = -1;
        Q_EMIT statusChanged(m_status);
    } else {
        QByteArray data = m_reply->readAll();
        if (data.isEmpty()) {
            m_queryId = 0;
            QTimer::singleShot(0, this, &XmlListModel::dataCleared);
        } else {
            m_queryId = XmlListModelQueryEngine::instance(qmlEngine(this))->doQuery(m_query, data, &m_roleObjects);
        }
        deleteReply();

        m_progress = 1.0;
        Q_EMIT progressChanged(m_progress);
    }
}

void XmlListModel::deleteReply()
{
    if (m_reply) {
        QObject::disconnect(m_reply, 0, this, 0);
        m_reply->deleteLater();
        m_reply = nullptr;
    }
}
#endif

void XmlListModel::requestProgress(qint64 received, qint64 total)
{
    if (m_status == Loading && total > 0) {
        m_progress = qreal(received)/total;
        Q_EMIT progressChanged(m_progress);
    }
}

void XmlListModel::dataCleared()
{
    XmlListModelQueryResult r;
    r.queryId = 0;
    queryCompleted(r);
}

void XmlListModel::queryError(void* object, const QString& error)
{
    for (int i = 0; i < m_roleObjects.count(); i++) {
        if (m_roleObjects.at(i) == static_cast<XmlListModelRole*>(object)) {
            qmlWarning(m_roleObjects.at(i)) << XmlListModel::tr("invalid query: \"%1\"").arg(error);
            return;
        }
    }
    qmlWarning(this) << XmlListModel::tr("invalid query: \"%1\"").arg(error);
}

void XmlListModel::queryCompleted(const XmlListModelQueryResult &result)
{
    if (result.queryId != m_queryId)
        return;

    int origCount = m_size;
    bool sizeChanged = result.data.count() != m_size;

    if (m_source.isEmpty())
        m_status = Null;
    else
        m_status = Ready;
    m_errorString.clear();
    m_queryId = -1;

    if (origCount > 0) {
        beginRemoveRows(QModelIndex(), 0, origCount - 1);
        endRemoveRows();
    }
    m_size = result.data.count();
    m_data = result.data;

    if (m_size > 0) {
        beginInsertRows(QModelIndex(), 0, m_size - 1);
        endInsertRows();
    }

    if (sizeChanged)
        Q_EMIT countChanged();

    Q_EMIT statusChanged(m_status);
}

void XmlListModel::notifyQueryStarted(bool remoteSource)
{
    m_progress = remoteSource ? 0.0 : 1.0;
    m_status = XmlListModel::Loading;
    m_errorString.clear();
    Q_EMIT progressChanged(m_progress);
    Q_EMIT statusChanged(m_status);
}




