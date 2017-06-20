/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the documentation of the Qt Toolkit.
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

#include "scenehelper.h"

QObject *SceneHelper::findEntity(Qt3DRender::QSceneLoader *loader, const QString &name)
{
    // The QSceneLoader instance is a component of an entity. The loaded scene
    // tree is added under this entity.
    QVector<Qt3DCore::QEntity *> entities = loader->entities();

    if (entities.isEmpty())
        return 0;

    // Technically there could be multiple entities referencing the scene loader
    // but sharing is discouraged, and in our case there will be one anyhow.
    Qt3DCore::QEntity *root = entities[0];

    // The scene structure and names always depend on the asset.
    return root->findChild<Qt3DCore::QEntity *>(name);
}

void SceneHelper::removeFromScene(Qt3DRender::QSceneLoader *loader, const QStringList &names)
{
    QVector<Qt3DCore::QEntity *> entities = loader->entities();

    if (entities.isEmpty())
        return;

    Qt3DCore::QEntity *root = entities[0];

    foreach (QString name, names) {
        QObject *entity = root->findChild<Qt3DCore::QEntity *>(name);
        entity->setParent(Q_NULLPTR);
    }
}

void SceneHelper::addBasicMaterials(Qt3DRender::QSceneLoader *loader,
                                    Qt3DRender::QMaterial *material, QStringList names)
{
    QVector<Qt3DCore::QEntity *> entities = loader->entities();

    if (entities.isEmpty())
        return;

    Qt3DCore::QEntity *root = entities[0];

    addComponents(names, root, material);
}

void SceneHelper::addTextureMaterial(Qt3DRender::QSceneLoader *loader,
                                     Qt3DRender::QMaterial *material, QString name)
{
    QVector<Qt3DCore::QEntity *> entities = loader->entities();

    if (entities.isEmpty())
        return;

    Qt3DCore::QEntity *root = entities[0];

    addComponent(name, root, material);
}

void SceneHelper::replaceMaterial(Qt3DRender::QSceneLoader *loader, const QString &name,
                                  Qt3DRender::QMaterial *material)
{
    QVector<Qt3DCore::QEntity *> entities = loader->entities();

    if (entities.isEmpty())
        return;

    Qt3DCore::QEntity *root = entities[0];
    Qt3DCore::QEntity *entity = root->findChild<Qt3DCore::QEntity *>(name);
    if (entity) {
#if (QT_VERSION >= QT_VERSION_CHECK(5, 7, 0))
        QVector<Qt3DCore::QComponent *> components = entity->components();
#else
        Qt3DCore::QComponentList components = entity->components();
#endif
        foreach (Qt3DCore::QComponent *comp, components) {
            if (qobject_cast<Qt3DRender::QMaterial *>(comp)) {
                entity->removeComponent(comp);
                break;
            }
        }
        entity->addComponent(material);
    }
}

void SceneHelper::addComponents(QStringList &names, Qt3DCore::QEntity *root,
                                Qt3DRender::QMaterial *material)
{
    foreach (QString name, names) {
        Qt3DCore::QEntity *entity = root->findChild<Qt3DCore::QEntity *>(name);
        if (entity) {
#if (QT_VERSION >= QT_VERSION_CHECK(5, 7, 0))
        QVector<Qt3DCore::QComponent *> components = entity->components();
#else
        Qt3DCore::QComponentList components = entity->components();
#endif
            foreach (Qt3DCore::QComponent *comp, components) {
                if (qobject_cast<Qt3DRender::QMaterial *>(comp)) {
                    //qDebug() << "   removing " << comp;
                    entity->removeComponent(comp);
                    break;
                }
            }
            entity->addComponent(material);
        }
    }
}

void SceneHelper::searchCamera(Qt3DRender::QSceneLoader *loader, const QString &name)
{
    QVector<Qt3DCore::QEntity *> entities = loader->entities();

    if (entities.isEmpty())
        return;

    Qt3DCore::QEntity *root = entities[0];
    Qt3DCore::QEntity *entity = root->findChild<Qt3DCore::QEntity *>(name);
    //qDebug() << "Found entity " << entity;
#if (QT_VERSION >= QT_VERSION_CHECK(5, 7, 0))
    QVector<Qt3DCore::QComponent *> components = entity->components();
#else
    Qt3DCore::QComponentList components = entity->components();
#endif
    foreach (Qt3DCore::QComponent *comp, components) {
#if (QT_VERSION >= QT_VERSION_CHECK(5, 7, 0))
        if (qobject_cast<Qt3DRender::QCameraLens *>(comp)) {
            Qt3DRender::QCameraLens *lens = qobject_cast<Qt3DRender::QCameraLens *>(comp);
            Q_UNUSED(lens)
        }
#else
        if (qobject_cast<Qt3DCore::QCameraLens *>(comp)) {
            Qt3DCore::QCameraLens *lens = qobject_cast<Qt3DCore::QCameraLens *>(comp);
        }
#endif

    }
}

void SceneHelper::addComponent(QString &name, Qt3DCore::QEntity *root,
                               Qt3DRender::QMaterial *material)
{

    Qt3DCore::QEntity *entity = root->findChild<Qt3DCore::QEntity *>(name);

    if (entity) {
#if (QT_VERSION >= QT_VERSION_CHECK(5, 7, 0))
        QVector<Qt3DCore::QComponent *> components = entity->components();
#else
        Qt3DCore::QComponentList components = entity->components();
#endif
        foreach (Qt3DCore::QComponent *comp, components) {
            if (qobject_cast<Qt3DRender::QMaterial *>(comp)) {
                entity->removeComponent(comp);
                break;
            }
        }

        entity->addComponent(material);
    } else {

    }
}

void SceneHelper::addListEntry(const QVariant &list, QObject *entry)
{
    QQmlListReference ref = list.value<QQmlListReference>();
    ref.append(entry);
}
