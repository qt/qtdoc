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

#ifndef XMLLISTMODEL_H
#define XMLLISTMODEL_H

#include <QtQml>
#include <QQmlContext>
#include <QQmlEngine>
#include <QAbstractItemModel>
#include <QThread>
#include <QByteArray>
#include <QMap>
#include <QMutex>
#include <QHash>
#include <QStringList>
#include <QTimer>
#include <QUrl>
#if QT_CONFIG(qml_network)
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QXmlStreamReader>
#endif


class QQmlContext;
struct XmlListModelQueryJob
{
    int queryId;
    QByteArray data;
    QString query;
    QStringList roleNames;
    QStringList roleQueries;
    QList<void*> roleQueryErrorId;
};
struct XmlListModelQueryResult {
    int queryId;
    QList<QHash<int, QString> > data;
};

class XmlListModelRole : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString elementName READ elementName WRITE setElementName NOTIFY elementNameChanged)
    Q_PROPERTY(QString attributeName READ attributeName WRITE setAttributeName NOTIFY attributeNameChanged)
    QML_ELEMENT

public:
    XmlListModelRole() = default;
    ~XmlListModelRole() = default;

    QString elementName() const;
    void setElementName(const QString &name);
    QString attributeName() const;
    void setAttributeName(const QString &attributeName);
    bool isValid() const;

signals:
    void elementNameChanged();
    void attributeNameChanged();

    private:
    QString m_elementName;
    QString m_attributeName;

};

class XmlListModel : public QAbstractListModel, public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)

    Q_PROPERTY(Status status READ status NOTIFY statusChanged)
    Q_PROPERTY(qreal progress READ progress NOTIFY progressChanged)
    Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QString query READ query WRITE setQuery NOTIFY queryChanged)
    Q_PROPERTY(QQmlListProperty<XmlListModelRole> roles READ roleObjects)
    Q_PROPERTY(int count READ count NOTIFY countChanged)
    QML_ELEMENT

public:
    XmlListModel(QObject *parent = nullptr);
    ~XmlListModel() = default;

    QModelIndex index(int row, int column, const QModelIndex &parent) const override;
    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    int count() const;

    QUrl source() const;
    void setSource(const QUrl&);

    QString query() const;
    void setQuery(const QString&);

    QQmlListProperty<XmlListModelRole> roleObjects();

    void appendRole(XmlListModelRole*);
    void clearRole();

    enum Status { Null, Ready, Loading, Error };
    Q_ENUM(Status)
    Status status() const;
    qreal progress() const;

    Q_INVOKABLE QString errorString() const;

    void classBegin() override;
    void componentComplete() override;

Q_SIGNALS:
    void statusChanged(XmlListModel::Status);
    void progressChanged(qreal progress);
    void countChanged();
    void sourceChanged();
    void queryChanged();

public Q_SLOTS:
    void reload();

private Q_SLOTS:
#if QT_CONFIG(qml_network)
    void requestFinished();
#endif
    void requestProgress(qint64,qint64);
    void dataCleared();
    void queryCompleted(const XmlListModelQueryResult &);
    void queryError(void* object, const QString& error);

private:
    Q_DISABLE_COPY(XmlListModel)

    void notifyQueryStarted(bool remoteSource);

    static void appendRole(QQmlListProperty<XmlListModelRole>*, XmlListModelRole*);
    static void clearRole(QQmlListProperty<XmlListModelRole>*);

#if QT_CONFIG(qml_network)
    void deleteReply();

    QNetworkReply *m_reply;
#endif

    int m_size;
    QUrl m_source;
    QString m_query;
    QStringList m_roleNames;
    QList<int> m_roles;
    QList<XmlListModelRole *> m_roleObjects;
    QList<QHash<int, QString> > m_data;
    bool m_isComponentComplete;
    Status m_status;
    QString m_errorString;
    qreal m_progress;
    int m_queryId;
    int m_redirectCount;
    int m_highestRole;

};

class XmlListModelQueryThreadObject;

class XmlListModelQueryEngine : public QThread
{
    Q_OBJECT
public:
    XmlListModelQueryEngine(QQmlEngine *eng);
    ~XmlListModelQueryEngine();

    int doQuery(QString query, QByteArray data, QList<XmlListModelRole *>* roles);
    void abort(int id);

    void processJobs();

    static XmlListModelQueryEngine *instance(QQmlEngine *engine);

signals:
    void queryCompleted(const XmlListModelQueryResult &);
    void error(void*, const QString&);

protected:
    void run() override;

private:
    void processQuery(XmlListModelQueryJob *job);
    void doQueryJob(XmlListModelQueryJob *job, XmlListModelQueryResult *currentResult);
    void processElement(XmlListModelQueryJob *currentJob, XmlListModelQueryResult*& currentResult, QString element, QXmlStreamReader &reader);

    QMutex m_mutex;
    XmlListModelQueryThreadObject *m_threadObject;
    QList<XmlListModelQueryJob> m_jobs;
    QSet<int> m_cancelledJobs;
    QAtomicInt m_queryIds;

    QQmlEngine *m_engine;
    QObject *m_eventLoopQuitHack;

    static QHash<QQmlEngine *, XmlListModelQueryEngine*> queryEngines;
    static QMutex queryEnginesMutex;
};

class XmlListModelQueryThreadObject : public QObject
{
    Q_OBJECT
public:
    XmlListModelQueryThreadObject(XmlListModelQueryEngine *);

    void processJobs();
    bool event(QEvent *e) override;

private:
    XmlListModelQueryEngine *m_queryEngine;
};

#endif
