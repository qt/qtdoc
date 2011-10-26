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

/*
  qmlcodeparser.cpp
*/

#include <private/qdeclarativejsast_p.h>
#include <private/qdeclarativejsastvisitor_p.h>

#include "qmlcodeparser.h"
#include "node.h"
#include "tree.h"
#include "config.h"
#include "qmlvisitor.h"
#include <qdebug.h>

QT_BEGIN_NAMESPACE

#define COMMAND_STARTPAGE               Doc::alias("startpage")
#define COMMAND_VARIABLE                Doc::alias("variable")

#define COMMAND_QMLCLASS                Doc::alias("qmlclass")
#define COMMAND_QMLPROPERTY             Doc::alias("qmlproperty")
#define COMMAND_QMLATTACHEDPROPERTY     Doc::alias("qmlattachedproperty")
#define COMMAND_QMLINHERITS             Doc::alias("inherits")
#define COMMAND_QMLSIGNAL               Doc::alias("qmlsignal")
#define COMMAND_QMLATTACHEDSIGNAL       Doc::alias("qmlattachedsignal")
#define COMMAND_QMLMETHOD               Doc::alias("qmlmethod")
#define COMMAND_QMLATTACHEDMETHOD       Doc::alias("qmlattachedmethod")
#define COMMAND_QMLDEFAULT              Doc::alias("default")
#define COMMAND_QMLBASICTYPE            Doc::alias("qmlbasictype")

QmlCodeParser::QmlCodeParser()
{
}

QmlCodeParser::~QmlCodeParser()
{
}

/*!
  Initializes the code parser base class. The \a config argument
  is passed to the initialization functions in the base class.

  Also creates a lexer and parser from QDeclarativeJS.
 */
void QmlCodeParser::initializeParser(const Config &config)
{
    CodeParser::initializeParser(config);

    lexer = new QDeclarativeJS::Lexer(&engine);
    parser = new QDeclarativeJS::Parser(&engine);
}

/*!
  Deletes the lexer and parser created by the constructor.
 */
void QmlCodeParser::terminateParser()
{
    delete lexer;
    delete parser;
}

/*!
  Returns "QML".
 */
QString QmlCodeParser::language()
{
    return "QML";
}

/*!
  Returns a filter string of "*.qml".
 */
QStringList QmlCodeParser::sourceFileNameFilter()
{
    return QStringList("*.qml");
}

/*!
  Parses the source file at \a filePath, creating nodes as
  needed and inserting them into the \a tree. \a location is
  used for error reporting.

  If it can't open the file at \a filePath, it reports an
  error and returns without doing anything.
 */
void QmlCodeParser::parseSourceFile(const Location& location,
                                    const QString& filePath,
                                    Tree *tree)
{
    QFile in(filePath);
    if (!in.open(QIODevice::ReadOnly)) {
        location.error(tr("Cannot open QML file '%1'").arg(filePath));
        return;
    }
    createOutputSubdirectory(location, filePath);

    QString document = in.readAll();
    in.close();

    Location fileLocation(filePath);

    QString newCode = document;
    extractPragmas(newCode);
    lexer->setCode(newCode, 1);

    QSet<QString> topicCommandsAllowed = topicCommands();
    QSet<QString> otherMetacommandsAllowed = otherMetaCommands();
    QSet<QString> metacommandsAllowed = topicCommandsAllowed +
        otherMetacommandsAllowed;

    if (parser->parse()) {
        QDeclarativeJS::AST::UiProgram *ast = parser->ast();
        QmlDocVisitor visitor(filePath,
                              newCode,
                              &engine,
                              tree,
                              metacommandsAllowed,
                              topicCommandsAllowed);
        QDeclarativeJS::AST::Node::accept(ast, &visitor);
    }
}

/*!
  This function is called when the parser finishes parsing
  the file, but in this case the function does nothing.
 */
void QmlCodeParser::doneParsingSourceFiles(Tree *tree)
{
}

/*!
  Returns the set of strings representing the topic commands.
 */
QSet<QString> QmlCodeParser::topicCommands()
{
    return QSet<QString>() << COMMAND_VARIABLE
                           << COMMAND_QMLCLASS
                           << COMMAND_QMLPROPERTY
                           << COMMAND_QMLATTACHEDPROPERTY
                           << COMMAND_QMLSIGNAL
                           << COMMAND_QMLATTACHEDSIGNAL
                           << COMMAND_QMLMETHOD
                           << COMMAND_QMLATTACHEDMETHOD
                           << COMMAND_QMLBASICTYPE;
}

/*!
  Returns the set of strings representing the common metacommands
  plus some other metacommands.
 */
QSet<QString> QmlCodeParser::otherMetaCommands()
{
    return commonMetaCommands() << COMMAND_STARTPAGE
                                << COMMAND_QMLINHERITS
                                << COMMAND_QMLDEFAULT;
}

/*!
  Copy and paste from src/declarative/qml/qdeclarativescriptparser.cpp.
  This function blanks out the section of the \a str beginning at \a idx
  and running for \a n characters.
*/
static void replaceWithSpace(QString &str, int idx, int n) 
{
    QChar *data = str.data() + idx;
    const QChar space(QLatin1Char(' '));
    for (int ii = 0; ii < n; ++ii)
        *data++ = space;
}

/*!
  Copy & paste from src/declarative/qml/qdeclarativescriptparser.cpp,
  then modified to return no values.

  Searches for ".pragma <value>" declarations within \a script.
  Currently supported pragmas are: library
*/
void QmlCodeParser::extractPragmas(QString &script)
{
    const QString pragma(QLatin1String("pragma"));
    const QString library(QLatin1String("library"));

    QDeclarativeJS::Lexer l(0);
    l.setCode(script, 0);

    int token = l.lex();

    while (true) {
        if (token != QDeclarativeJSGrammar::T_DOT)
            return;

        int startOffset = l.tokenOffset();
        int startLine = l.tokenStartLine();

        token = l.lex();

        if (token != QDeclarativeJSGrammar::T_IDENTIFIER ||
            l.tokenStartLine() != startLine ||
            script.mid(l.tokenOffset(), l.tokenLength()) != pragma)
            return;

        token = l.lex();

        if (token != QDeclarativeJSGrammar::T_IDENTIFIER ||
            l.tokenStartLine() != startLine)
            return;

        QString pragmaValue = script.mid(l.tokenOffset(), l.tokenLength());
        int endOffset = l.tokenLength() + l.tokenOffset();

        token = l.lex();
        if (l.tokenStartLine() == startLine)
            return;

        if (pragmaValue == QLatin1String("library"))
            replaceWithSpace(script, startOffset, endOffset - startOffset);
        else
            return;
    }
    return;
}

QT_END_NAMESPACE
