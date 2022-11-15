// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "addressbookmodel.h"
#include "contactentry.h"

#include <QMutexLocker>

AddressBookModel::AddressBookModel(QSharedPointer<RestAccessManager> manager, QObject *parent)
    : QAbstractTableModel(parent), accessManager(std::move(manager))
{
    QObject::connect(accessManager.get(), &RestAccessManager::contactsChanged, this,
                     &AddressBookModel::updateContacts);
}

AddressBookModel::~AddressBookModel() = default;

int AddressBookModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    QMutexLocker lock(&contactsMtx);
    return contacts.size();
}

int AddressBookModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return ContactEntry::size();
}

QVariant AddressBookModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (orientation == Qt::Orientation::Horizontal) {
        switch (section) {
        case 0:
            return ""; // ID is not shown
        case 1:
            return "Name";
        case 2:
            return "Address";
        }
    }
    return QVariant();
}

QVariant AddressBookModel::data(const QModelIndex &index, int role) const
{
    QMutexLocker lock(&contactsMtx);

    if (index.row() < 0 || index.row() >= contacts.count())
        return QVariant();

    const ContactEntry &contact = contacts.at(index.row());
    QVariant ret;

    switch (role) {
    case AddressBookRoles::IdRole:
        ret = contact.id;
        break;

    case AddressBookRoles::NameRole:
        ret = contact.name;
        break;

    case AddressBookRoles::AddressRole:
        ret = contact.address;
        break;
    }
    return ret;
}

QHash<int, QByteArray> AddressBookModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[AddressBookRoles::IdRole] = "id";
    roles[AddressBookRoles::NameRole] = "name";
    roles[AddressBookRoles::AddressRole] = "address";
    return roles;
}

Q_INVOKABLE void AddressBookModel::setAuthorizationHeader(const QString &key, const QString &value)
{
    accessManager->setAuthorizationHeader(key, value);
}

Q_INVOKABLE void AddressBookModel::addContact(const QString &name, const QString &contact)
{
    accessManager->addContact(ContactEntry{ 0, name, contact });
}

Q_INVOKABLE void AddressBookModel::updateContact(qint64 id, const QString &name,
                                                 const QString &contact)
{
    accessManager->updateContact(ContactEntry{ id, name, contact });
}

Q_INVOKABLE void AddressBookModel::removeContact(const qint64 id)
{
    accessManager->deleteContact(id);
}

Q_INVOKABLE void AddressBookModel::refresh()
{
    this->updateContacts();
}

void AddressBookModel::updateContacts()
{
    auto toContactEntry = [](const auto &it) {
        return ContactEntry{ it.first, it.second.name, it.second.address };
    };
    QList<ContactEntry> tmpContacts;
    const RestAccessManager::ContactsMap contactsMap = accessManager->getContacts();
    std::transform(contactsMap.constKeyValueBegin(), contactsMap.constKeyValueEnd(),
                   std::back_inserter(tmpContacts), toContactEntry);

    this->beginInsertRows(this->index(-1, -1), 0, this->rowCount());
    {
        QMutexLocker lock(&contactsMtx);
        contacts.swap(tmpContacts);
    }
    this->endInsertRows();
}
