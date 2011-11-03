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
#include <private/qdeclarativejsast_p.h>
#include <private/qdeclarativejsastfwd_p.h>
#include <private/qdeclarativejsengine_p.h>
#include <qdebug.h>
#include "node.h"
#include "codeparser.h"
#include "qmlvisitor.h"

QT_BEGIN_NAMESPACE

#define COMMAND_DEPRECATED              Doc::alias(QLatin1String("deprecated")) // ### don't document
#define COMMAND_INGROUP                 Doc::alias(QLatin1String("ingroup"))
#define COMMAND_INTERNAL                Doc::alias(QLatin1String("internal"))
#define COMMAND_OBSOLETE                Doc::alias(QLatin1String("obsolete"))
#define COMMAND_PAGEKEYWORDS            Doc::alias(QLatin1String("pagekeywords"))
#define COMMAND_PRELIMINARY             Doc::alias(QLatin1String("preliminary"))
#define COMMAND_SINCE                   Doc::alias(QLatin1String("since"))

#define COMMAND_QMLCLASS                Doc::alias(QLatin1String("qmlclass"))
#define COMMAND_QMLMODULE               Doc::alias(QLatin1String("qmlmodule"))
#define COMMAND_QMLPROPERTY             Doc::alias(QLatin1String("qmlproperty"))
#define COMMAND_QMLATTACHEDPROPERTY     Doc::alias(QLatin1String("qmlattachedproperty"))
#define COMMAND_QMLINHERITS             Doc::alias(QLatin1String("inherits"))
#define COMMAND_INQMLMODULE             Doc::alias(QLatin1String("inqmlmodule"))
#define COMMAND_QMLSIGNAL               Doc::alias(QLatin1String("qmlsignal"))
#define COMMAND_QMLATTACHEDSIGNAL       Doc::alias(QLatin1String("qmlattachedsignal"))
#define COMMAND_QMLMETHOD               Doc::alias(QLatin1String("qmlmethod"))
#define COMMAND_QMLATTACHEDMETHOD       Doc::alias(QLatin1String("qmlattachedmethod"))
#define COMMAND_QMLDEFAULT              Doc::alias(QLatin1String("default"))
#define COMMAND_QMLBASICTYPE            Doc::alias(QLatin1String("qmlbasictype"))
#define COMMAND_QMLMODULE               Doc::alias(QLatin1String("qmlmodule"))

/*!
  The constructor stores all the parameters in local data members.
 */
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

/*!
  The destructor does nothing.
 */
QmlDocVisitor::~QmlDocVisitor()
{
    // nothing.
}

/*!
  Returns the location of thre nearest comment above the \a offset.
 */
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

/*!
  Finds the nearest unused qdoc comment above the QML entity
  represented by the \a node and processes the qdoc commands
  in that comment. The proceesed documentation is stored in
  the \a node.

  If a qdoc comment is found about \a location, true is returned.
  If a comment is not found there, false is returned.
 */
bool QmlDocVisitor::applyDocumentation(QDeclarativeJS::AST::SourceLocation location, Node* node)
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
        applyMetacommands(loc, node, doc);
        usedComments.insert(loc.offset);
        if (doc.isEmpty())
            return false;
        return true;
    }
    Location codeLoc(filePath);
    codeLoc.setLineNo(location.startLine);
    node->setLocation(codeLoc);
    return false;
}

/*!
  Applies the metacommands found in the comment.
 */
void QmlDocVisitor::applyMetacommands(QDeclarativeJS::AST::SourceLocation location,
                                      Node* node,
                                      Doc& doc)
{
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
            if (topic == COMMAND_QMLCLASS) {
            }
            else if (topic == COMMAND_QMLPROPERTY) {
                if (node->type() == Node::QmlProperty) {
                    QmlPropertyNode* qpn = static_cast<QmlPropertyNode*>(node);
                    if (qpn->dataType() == "alias") {
                        QStringList part = args[0].split(" ");
                        qpn->setDataType(part[0]);
                    }
                }
            }
            else if (topic == COMMAND_QMLMODULE) {
            }
            else if (topic == COMMAND_QMLATTACHEDPROPERTY) {
            }
            else if (topic == COMMAND_QMLSIGNAL) {
            }
            else if (topic == COMMAND_QMLATTACHEDSIGNAL) {
            }
            else if (topic == COMMAND_QMLMETHOD) {
            }
            else if (topic == COMMAND_QMLATTACHEDMETHOD) {
            }
            else if (topic == COMMAND_QMLBASICTYPE) {
            }
        }
        metacommands.subtract(topics);
        i = metacommands.begin();
        while (i != metacommands.end()) {
            QString command = *i;
            args = doc.metaCommandArgs(command);
            if (command == COMMAND_DEPRECATED) {
                node->setStatus(Node::Deprecated);
            }
            else if (command == COMMAND_INQMLMODULE) {
                node->setQmlModuleName(args[0]);
                tree->addToQmlModule(node,args[0]);
                QString qmq = node->qmlModuleQualifier();
                QmlClassNode* qcn = static_cast<QmlClassNode*>(node);
                QmlClassNode::moduleMap.insert(qmq + "::" + node->name(), qcn);
            }
            else if (command == COMMAND_QMLINHERITS) {
                if (node->name() == args[0])
                    doc.location().warning(tr("%1 tries to inherit itself").arg(args[0]));
                else {
                    qDebug() << "QML Component:" << node->name() << "inherits:" << args[0];
                    CodeParser::setLink(node, Node::InheritsLink, args[0]);
                    if (node->subType() == Node::QmlClass) {
                        QmlClassNode::addInheritedBy(args[0],node);
                    }
                }
            }
            else if (command == COMMAND_QMLDEFAULT) {
                if (node->type() == Node::QmlProperty) {
                    QmlPropertyNode* qpn = static_cast<QmlPropertyNode*>(node);
                    qpn->setDefault();
                }
            }
            else if (command == COMMAND_INGROUP) {
                tree->addToGroup(node, args[0]);
            }
            else if (command == COMMAND_INTERNAL) {
                node->setAccess(Node::Private);
                node->setStatus(Node::Internal);
            }
            else if (command == COMMAND_OBSOLETE) {
                if (node->status() != Node::Compat)
                    node->setStatus(Node::Obsolete);
            }
            else if (command == COMMAND_PAGEKEYWORDS) {
                // Not done yet. Do we need this?
            }
            else if (command == COMMAND_PRELIMINARY) {
                node->setStatus(Node::Preliminary);
            }
            else if (command == COMMAND_SINCE) {
                QString arg = args.join(" ");
                node->setSince(arg);
            }
            else {
                doc.location().warning(tr("The \%1 command is ignored in QML files").arg(command));
            }
            ++i;
        }
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
    QString type = definition->qualifiedTypeNameId->name.toString();
    nestingLevel++;

    if (current->type() == Node::Namespace) {
        QmlClassNode *component = new QmlClassNode(current, name, 0);
        component->setTitle(QLatin1String("QML ") + name + QLatin1String(" Component"));
        component->setImportList(importList);

        if (applyDocumentation(definition->firstSourceLocation(), component)) {
            QmlClassNode::addInheritedBy(type, component);
            if (!component->links().contains(Node::InheritsLink))
                component->setLink(Node::InheritsLink, type, type);
        }
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
    QDeclarativeJS::AST::UiImport* imp = imports->import;
    quint32 length =  imp->versionToken.offset - imp->fileNameToken.offset - 1;
    QString module = document.mid(imp->fileNameToken.offset,length);
    QString version = document.mid(imp->versionToken.offset, imp->versionToken.length);
    if (version.size() > 1) {
        int dot = version.lastIndexOf(QChar('.'));
        if (dot > 0)
            version = version.left(dot);
    }
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
            s += "." + fme->name.toString();
        }
        else if (en->kind == QDeclarativeJS::AST::Node::Kind_IdentifierExpression) {
            IE* ie = (IE*) en;
            s = ie->name.toString();
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

                QString name = member->name.toString();
                FunctionNode *qmlSignal = new FunctionNode(Node::QmlSignal, current, name, false);

                QList<Parameter> parameters;
                for (QDeclarativeJS::AST::UiParameterList *it = member->parameters; it; it = it->next) {
                    if (!it->type.isEmpty() && !it->name.isEmpty())
                        parameters.append(Parameter(it->type.toString(), "", it->name.toString()));
                }

                qmlSignal->setParameters(parameters);
                applyDocumentation(member->firstSourceLocation(), qmlSignal);
            }
        }
        break;
    }
    case QDeclarativeJS::AST::UiPublicMember::Property:
    {
        QString type = member->memberType.toString();
        QString name = member->name.toString();

        if (current->type() == Node::Fake) {
            QmlClassNode *qmlClass = static_cast<QmlClassNode *>(current);
            if (qmlClass) {
                QString name = member->name.toString();
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
            QString name = fd->name.toString();
            FunctionNode* qmlMethod = new FunctionNode(Node::QmlMethod, current, name, false);
            QList<Parameter> parameters;
            QDeclarativeJS::AST::FormalParameterList* formals = fd->formals;
            if (formals) {
                QDeclarativeJS::AST::FormalParameterList* fpl = formals;
                do {
                    parameters.append(Parameter(QString(""), QString(""), fpl->name.toString()));
                    fpl = fpl->next;
                } while (fpl && fpl != formals);
                qmlMethod->setParameters(parameters);
            }
            applyDocumentation(fd->firstSourceLocation(), qmlMethod);
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

/*!
  Begin the visit of the signal handler declaration \a sb, but only
  if the nesting level is 1.
 */
bool QmlDocVisitor::visit(QDeclarativeJS::AST::UiScriptBinding* sb)
{
    if (nestingLevel > 1)
        return true;
    if (current->type() == Node::Fake) {
        QString handler = sb->qualifiedId->name.toString();
        if (handler.length() > 2 && handler.startsWith("on") && handler.at(2).isUpper()) {
            QmlClassNode* qmlClass = static_cast<QmlClassNode*>(current);
            if (qmlClass) {
                FunctionNode* qmlSH = new FunctionNode(Node::QmlSignalHandler,current,handler,false);
                applyDocumentation(sb->firstSourceLocation(), qmlSH);
            }
        }
    }
    return true;
}

void QmlDocVisitor::endVisit(QDeclarativeJS::AST::UiScriptBinding* sb)
{
    lastEndOffset = sb->lastSourceLocation().end();
}

bool QmlDocVisitor::visit(QDeclarativeJS::AST::UiQualifiedId* )
{
    return true;
}

void QmlDocVisitor::endVisit(QDeclarativeJS::AST::UiQualifiedId* )
{
    // nothing.
}

QT_END_NAMESPACE
