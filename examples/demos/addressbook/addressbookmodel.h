// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef ADDRESSBOOKMODEL_H
#define ADDRESSBOOKMODEL_H

#include "contactentry.h"
#include "restaccessmanager.h"

#include <QAbstractItemModel>
#include <QMutex>
#include <QSharedPointer>
#include <QtQml/qqml.h>

class AddressBookModel : public QAbstractTableModel
{
    Q_OBJECT
    QML_ELEMENT
public:
    enum AddressBookRoles { IdRole = Qt::UserRole + 1, NameRole, AddressRole };
    Q_ENUM(AddressBookRoles)

    explicit AddressBookModel(QSharedPointer<RestAccessManager> manager, QObject *parent = nullptr);
    ~AddressBookModel();

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void setAuthorizationHeader(const QString &key, const QString &value);
    Q_INVOKABLE void addContact(const QString &name, const QString &contact);
    Q_INVOKABLE void updateContact(qint64 id, const QString &name, const QString &contact);
    Q_INVOKABLE void removeContact(qint64 id);
    Q_INVOKABLE void refresh();

signals:
    void contactsChanged();

private slots:
    void updateContacts();

private:
    QSharedPointer<RestAccessManager> accessManager;
    mutable QMutex contactsMtx;
    QList<ContactEntry> contacts;
};

#endif // ADDRESSBOOKMODEL_H
