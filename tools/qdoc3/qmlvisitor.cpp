/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the tools applications of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** GNU Lesser General Public License Usage
** This file may be used under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation and
** appearing in the file LICENSE.LGPL included in the packaging of this
** file. Please review the following information to ensure the GNU Lesser
** General Public License version 2.1 requirements will be met:
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights. These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU General
** Public License version 3.0 as published by the Free Software Foundation
** and appearing in the file LICENSE.GPL included in the packaging of this
** file. Please review the following information to ensure the GNU General
** Public License version 3.0 requirements will be met:
** http://www.gnu.org/copyleft/gpl.html.
**
** Other Usage
** Alternatively, this file may be used in accordance with the terms and
** conditions contained in a signed written agreement between you and Nokia.
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include <QFileInfo>
#include <QStringList>
#include <QtGlobal>
#include "declarativeparser/qdeclarativejsast_p.h"
#include "declarativeparser/qdeclarativejsastfwd_p.h"
#include "declarativeparser/qdeclarativejsengine_p.h"
#include <qdebug.h>
#include "node.h"
#include "qmlvisitor.h"

QT_BEGIN_NAMESPACE

static bool debug = false;

QmlDocVisitor::QmlDocVisitor(const QString &filePath,
                             const QString &code,
                             QDeclarativeJS::Engine *engine,
                             Tree *tree,
                             QSet<QString> &commands,
                             QSet<QString> &topics)
    : nestingLevel(0)
{
    this->filePath = filePath;
    this->name = QFileInfo(filePath).baseName();
    document = code;
    this->engine = engine;
    this->tree = tree;
    this->commands = commands;
    this->topics = topics;
    current = tree->root();
}

QmlDocVisitor::~QmlDocVisitor()
{
}

QDeclarativeJS::AST::SourceLocation QmlDocVisitor::precedingComment(quint32 offset) const
{
    QListIterator<QDeclarativeJS::AST::SourceLocation> it(engine->comments());
    it.toBack();

    while (it.hasPrevious()) {

        QDeclarativeJS::AST::SourceLocation loc = it.previous();

        if (loc.begin() <= lastEndOffset)
            // Return if we reach the end of the preceding structure.
            break;

        else if (usedComments.contains(loc.begin()))
            // Return if we encounter a previously used comment.
            break;

        else if (loc.begin() > lastEndOffset && loc.end() < offset) {

            // Only examine multiline comments in order to avoid snippet markers.
            if (document.mid(loc.offset - 1, 1) == "*") {
                QString comment = document.mid(loc.offset, loc.length);
                if (comment.startsWith("!") || comment.startsWith("*"))
                    return loc;
            }
        }
    }

    return QDeclarativeJS::AST::SourceLocation();
}

void QmlDocVisitor::applyDocumentation(QDeclarativeJS::AST::SourceLocation location, Node *node)
{
    QDeclarativeJS::AST::SourceLocation loc = precedingComment(location.begin());

    if (loc.isValid()) {
        QString source = document.mid(loc.offset, loc.length);
        Location start(filePath);
        start.setLineNo(loc.startLine);
        start.setColumnNo(loc.startColumn);
        Location finish(filePath);
        finish.setLineNo(loc.startLine);
        finish.setColumnNo(loc.startColumn);

        Doc doc(start, finish, source.mid(1), commands);
        node->setDoc(doc);
        QSet<QString> metacommands = doc.metaCommandsUsed();
        if (metacommands.count() > 0) {
            QString topic;
            QStringList args;
            QSet<QString>::iterator i = metacommands.begin();
            while (i != metacommands.end()) {
                if (topics.contains(*i)) {
                    topic = *i;
                    break;
                }
                ++i;
            }
            if (!topic.isEmpty()) {
                args = doc.metaCommandArgs(topic);
                // process the topic command here.
            }
            metacommands.subtract(topics);
            i = metacommands.begin();
            while (i != metacommands.end()) {
                QString command = *i;
                args = doc.metaCommandArgs(command);
                // process the metacommand here.
                ++i;
            }
        }
        usedComments.insert(loc.offset);
    }
}

/*!

  Begin the visit of the object \a definition, recording it in a tree
  structure.  Increment the object nesting level, which is used to
  test whether we are at the public API level. The public level is
  level 1.
*/
bool QmlDocVisitor::visit(QDeclarativeJS::AST::UiObjectDefinition *definition)
{
    QString type = definition->qualifiedTypeNameId->name->asString();
    nestingLevel++;

    if (current->type() == Node::Namespace) {
        QmlClassNode *component = new QmlClassNode(current, name, 0);
        component->setTitle(QLatin1String("QML ") + name + QLatin1String(" Component"));

        QmlClassNode::addInheritedBy(type, component);
        component->setLink(Node::InheritsLink, type, type);

        applyDocumentation(definition->firstSourceLocation(), component);

        current = component;
    }

    return true;
}

/*!
  End the visit of the object \a definition. In particular,
  decrement the object nesting level, which is used to test
  whether we are at the public API level. The public API
  level is level 1. It won't decrement below 0.
 */
void QmlDocVisitor::endVisit(QDeclarativeJS::AST::UiObjectDefinition *definition)
{
    if (nestingLevel > 0)
        --nestingLevel;
    lastEndOffset = definition->lastSourceLocation().end();
}

/*!
  Note that the imports list can be traversed by iteration to obtain
  all the imports in the document at once, having found just one:

  *it = imports; it; it = it->next

 */
bool QmlDocVisitor::visit(QDeclarativeJS::AST::UiImportList *imports)
{
    QString module = document.mid(imports->import->fileNameToken.offset,
                                  imports->import->fileNameToken.length);
    QString version = document.mid(imports->import->versionToken.offset,
                                   imports->import->versionToken.length);
    importList.append(QPair<QString, QString>(module, version));

    return true;
}

/*!
  End the visit of the imports list.
 */
void QmlDocVisitor::endVisit(QDeclarativeJS::AST::UiImportList *definition)
{
    lastEndOffset = definition->lastSourceLocation().end();
}

typedef QDeclarativeJS::AST::ExpressionNode EN;
typedef QDeclarativeJS::AST::IdentifierExpression IE;
typedef QDeclarativeJS::AST::FieldMemberExpression FME;

static QString reconstituteFieldMemberExpression(EN* en)
{
    QString s;
    if (en) {
        qDebug() << "  There is an expression" << en->kind;
        if (en->kind == QDeclarativeJS::AST::Node::Kind_FieldMemberExpression) {
            FME* fme = (FME*) en;
            s = reconstituteFieldMemberExpression(fme->base);
            s += "." + fme->name->asString();
        }
        else if (en->kind == QDeclarativeJS::AST::Node::Kind_IdentifierExpression) {
            IE* ie = (IE*) en;
            s = ie->name->asString();
        }
        else {
            qDebug() << "    But it wasn't a recognized expression kind";
        }
    }
    return s;
}

/*!
    Visits the public \a member declaration, which can be a
    signal or a property. It is a custom signal or property.
    Only visit the \a member if the nestingLevel is 1.
*/
bool QmlDocVisitor::visit(QDeclarativeJS::AST::UiPublicMember *member)
{
    if (nestingLevel > 1)
        return true;
    switch (member->type) {
    case QDeclarativeJS::AST::UiPublicMember::Signal:
    {
        if (current->type() == Node::Fake) {
            QmlClassNode *qmlClass = static_cast<QmlClassNode *>(current);
            if (qmlClass) {

                QString name = member->name->asString();
                FunctionNode *qmlSignal = new FunctionNode(Node::QmlSignal, current, name, false);

                QList<Parameter> parameters;
                for (QDeclarativeJS::AST::UiParameterList *it = member->parameters; it; it = it->next) {
                    if (it->type && it->name)
                        parameters.append(Parameter(it->type->asString(), "", it->name->asString()));
                }

                qmlSignal->setParameters(parameters);
                applyDocumentation(member->firstSourceLocation(), qmlSignal);
            }
        }
        break;
    }
    case QDeclarativeJS::AST::UiPublicMember::Property:
    {
        QString type = member->memberType->asString();
        QString name = member->name->asString();

        if (current->type() == Node::Fake) {
            QmlClassNode *qmlClass = static_cast<QmlClassNode *>(current);
            if (qmlClass) {
                QString name = member->name->asString();
                QmlPropertyNode *qmlPropNode = new QmlPropertyNode(qmlClass, name, type, false);
                qmlPropNode->setWritable(!member->isReadonlyMember);
                if (member->isDefaultMember)
                    qmlPropNode->setDefault();
                applyDocumentation(member->firstSourceLocation(), qmlPropNode);
            }
#if 0
            if (qmlClass) {
                QString name = member->name->asString();
                QmlPropGroupNode *qmlPropGroup = new QmlPropGroupNode(qmlClass, name, false);
                if (member->isDefaultMember)
                    qmlPropGroup->setDefault();
                QmlPropertyNode *qmlPropNode = new QmlPropertyNode(qmlPropGroup, name, type, false);
                qmlPropNode->setWritable(!member->isReadonlyMember);
                applyDocumentation(member->firstSourceLocation(), qmlPropGroup);
            }
#endif
        }
        break;
    }
    default:
        return false;
    }

    return true;
}

/*!
  End the visit of the \a member.
 */
void QmlDocVisitor::endVisit(QDeclarativeJS::AST::UiPublicMember* member)
{
    lastEndOffset = member->lastSourceLocation().end();
}

bool QmlDocVisitor::visit(QDeclarativeJS::AST::IdentifierPropertyName *idproperty)
{
    return true;
}

/*!
 */
bool QmlDocVisitor::visit(QDeclarativeJS::AST::UiSignature *signature)
{
    qDebug() << "SIGNATURE";
    if (current->type() == Node::Fake) {
        QmlClassNode *qmlClass = static_cast<QmlClassNode *>(current);
        if (qmlClass) {
            qDebug() << "GOT HEAH:" << qmlClass->name();
            QDeclarativeJS::AST::UiFormalList *formals = signature->formals;
            if (formals) {
                QDeclarativeJS::AST::UiFormalList *fl = formals;
                do {
                    QDeclarativeJS::AST::UiFormal *f = fl->formal;
                    fl = fl->next;
                } while (fl != formals);
            }
        }
    }
    return true;
}

/*!
 */
void QmlDocVisitor::endVisit(QDeclarativeJS::AST::UiSignature *definition)
{
    lastEndOffset = definition->lastSourceLocation().end();
}

/*!
  Begin the visit of the function declaration \a fd, but only
  if the nesting level is 1.
 */
bool QmlDocVisitor::visit(QDeclarativeJS::AST::FunctionDeclaration* fd)
{
    if (nestingLevel > 1)
        return true;
    if (current->type() == Node::Fake) {
        QmlClassNode* qmlClass = static_cast<QmlClassNode*>(current);
        if (qmlClass) {
            QString name = fd->name->asString();
            FunctionNode* qmlMethod = new FunctionNode(Node::QmlMethod, current, name, false);
            QList<Parameter> parameters;
            QDeclarativeJS::AST::FormalParameterList* formals = fd->formals;
            if (formals) {
                QDeclarativeJS::AST::FormalParameterList* fpl = formals;
                do {
                    parameters.append(Parameter(QString(""), QString(""), fpl->name->asString()));
                    fpl = fpl->next;
                } while (fpl && fpl != formals);
                qmlMethod->setParameters(parameters);
                applyDocumentation(fd->firstSourceLocation(), qmlMethod);
            }
        }
    }
    return true;
}

/*!
  End the visit of the function declaration, \a fd.
 */
void QmlDocVisitor::endVisit(QDeclarativeJS::AST::FunctionDeclaration* fd)
{
    lastEndOffset = fd->lastSourceLocation().end();
}

QT_END_NAMESPACE
