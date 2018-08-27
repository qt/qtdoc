/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the test suite of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:GPL-EXCEPT$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation with exceptions as appearing in the file LICENSE.GPL3-EXCEPT
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include <private/qqmljsengine_p.h>
#include <private/qqmljsparser_p.h>
#include <private/qqmljslexer_p.h>
#include <private/qqmljsastvisitor_p.h>
#include <private/qqmljsast_p.h>

#include <qtest.h>
#include <QDir>
#include <QDebug>
#include <cstdlib>

class tst_qqmlparser : public QObject
{
    Q_OBJECT
public:
    tst_qqmlparser();

private slots:
    void initTestCase();
#if !defined(QTEST_CROSS_COMPILED) // sources not available when cross compiled
    void qmlParser_data();
    void qmlParser();
#endif
    void invalidEscapeSequence();
    void stringLiteral();
    void noSubstitutionTemplateLiteral();
    void templateLiteral();

private:
    QStringList excludedDirs;

    QStringList findFiles(const QDir &);
};

namespace check {

using namespace QQmlJS;

class Check: public AST::Visitor
{
    QList<AST::Node *> nodeStack;

public:
    void operator()(AST::Node *node)
    {
        AST::Node::accept(node, this);
    }

    void checkNode(AST::Node *node)
    {
        if (! nodeStack.isEmpty()) {
            AST::Node *parent = nodeStack.last();
            const quint32 parentBegin = parent->firstSourceLocation().begin();
            const quint32 parentEnd = parent->lastSourceLocation().end();

            if (node->firstSourceLocation().begin() < parentBegin)
                qDebug() << "first source loc failed: node:" << node->kind << "at" << node->firstSourceLocation().startLine << "/" << node->firstSourceLocation().startColumn
                         << "parent" << parent->kind << "at" << parent->firstSourceLocation().startLine << "/" << parent->firstSourceLocation().startColumn;
            if (node->lastSourceLocation().end() > parentEnd)
                qDebug() << "first source loc failed: node:" << node->kind << "at" << node->lastSourceLocation().startLine << "/" << node->lastSourceLocation().startColumn
                         << "parent" << parent->kind << "at" << parent->lastSourceLocation().startLine << "/" << parent->lastSourceLocation().startColumn;

            QVERIFY(node->firstSourceLocation().begin() >= parentBegin);
            QVERIFY(node->lastSourceLocation().end() <= parentEnd);
        }
    }

    virtual bool preVisit(AST::Node *node)
    {
        checkNode(node);
        nodeStack.append(node);
        return true;
    }

    virtual void postVisit(AST::Node *)
    {
        nodeStack.removeLast();
    }
};

}

tst_qqmlparser::tst_qqmlparser()
{
}

void tst_qqmlparser::initTestCase()
{
    // Add directories you want excluded here:
    // excludedDirs << "exclude/this/dir";
}

QStringList tst_qqmlparser::findFiles(const QDir &d)
{
    for (int ii = 0; ii < excludedDirs.count(); ++ii) {
        QString s = excludedDirs.at(ii);
        if (d.absolutePath().endsWith(s))
            return QStringList();
    }

    QStringList rv;

    QStringList files = d.entryList(QStringList() << QLatin1String("*.qml") << QLatin1String("*.js"),
                                    QDir::Files);
    foreach (const QString &file, files) {
        rv << d.absoluteFilePath(file);
    }

    QStringList dirs = d.entryList(QDir::Dirs | QDir::NoDotAndDotDot |
                                   QDir::NoSymLinks);
    foreach (const QString &dir, dirs) {
        QDir sub = d;
        sub.cd(dir);
        rv << findFiles(sub);
    }

    return rv;
}

/*
This test checks all the qml and js files in the QtQml UI source tree
and ensures that the subnode's source locations are inside parent node's source locations
*/

#if !defined(QTEST_CROSS_COMPILED) // sources not available when cross compiled
void tst_qqmlparser::qmlParser_data()
{
    QTest::addColumn<QString>("file");

    QString examples = QLatin1String(SRCDIR) + "/../../../../examples/";
    QString tests = QLatin1String(SRCDIR) + "/../../../../tests/";

    QStringList files;
    files << findFiles(QDir(examples));
    files << findFiles(QDir(tests));

    foreach (const QString &file, files)
        QTest::newRow(qPrintable(file)) << file;
}
#endif

#if !defined(QTEST_CROSS_COMPILED) // sources not available when cross compiled
void tst_qqmlparser::qmlParser()
{
    QFETCH(QString, file);

    using namespace QQmlJS;

    QString code;

    QFile f(file);
    if (f.open(QFile::ReadOnly))
        code = QString::fromUtf8(f.readAll());

    const bool qmlMode = file.endsWith(QLatin1String(".qml"));

    Engine engine;
    Lexer lexer(&engine);
    lexer.setCode(code, 1, qmlMode);
    Parser parser(&engine);
    bool ok = qmlMode ? parser.parse() : parser.parseProgram();

    if (ok) {
        check::Check chk;
        chk(parser.rootNode());
    }
}
#endif

void tst_qqmlparser::invalidEscapeSequence()
{
    using namespace QQmlJS;

    Engine engine;
    Lexer lexer(&engine);
    lexer.setCode(QLatin1String("\"\\"), 1);
    Parser parser(&engine);
    parser.parse();
}

void tst_qqmlparser::stringLiteral()
{
    using namespace QQmlJS;

    Engine engine;
    Lexer lexer(&engine);
    QLatin1String code("'hello string'");
    lexer.setCode(code , 1);
    Parser parser(&engine);
    QVERIFY(parser.parseExpression());
    AST::ExpressionNode *expression = parser.expression();
    QVERIFY(expression);
    auto *literal = QQmlJS::AST::cast<QQmlJS::AST::StringLiteral *>(expression);
    QVERIFY(literal);
    QCOMPARE(literal->value, "hello string");
    QCOMPARE(literal->firstSourceLocation().begin(), 0);
    QCOMPARE(literal->lastSourceLocation().end(), code.size());
}

void tst_qqmlparser::noSubstitutionTemplateLiteral()
{
    using namespace QQmlJS;

    Engine engine;
    Lexer lexer(&engine);
    QLatin1String code("`hello template`");
    lexer.setCode(code, 1);
    Parser parser(&engine);
    QVERIFY(parser.parseExpression());
    AST::ExpressionNode *expression = parser.expression();
    QVERIFY(expression);

    auto *literal = QQmlJS::AST::cast<QQmlJS::AST::TemplateLiteral *>(expression);
    QVERIFY(literal);

    QCOMPARE(literal->value, "hello template");
    QCOMPARE(literal->firstSourceLocation().begin(), 0);
    QCOMPARE(literal->lastSourceLocation().end(), code.size());
}

void tst_qqmlparser::templateLiteral()
{
    using namespace QQmlJS;

    Engine engine;
    Lexer lexer(&engine);
    QLatin1String code("`one plus one equals ${1+1}!`");
    lexer.setCode(code, 1);
    Parser parser(&engine);
    QVERIFY(parser.parseExpression());
    AST::ExpressionNode *expression = parser.expression();
    QVERIFY(expression);

    auto *templateLiteral = QQmlJS::AST::cast<QQmlJS::AST::TemplateLiteral *>(expression);
    QVERIFY(templateLiteral);

    QCOMPARE(templateLiteral->firstSourceLocation().begin(), 0);
    auto *e = templateLiteral->expression;
    QVERIFY(e);
}

QTEST_MAIN(tst_qqmlparser)

#include "tst_qqmlparser.moc"
