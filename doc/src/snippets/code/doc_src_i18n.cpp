// Copyright (C) 2019 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

using namespace Qt::StringLiterals;

//! [0]
LoginWidget::LoginWidget()
{
    QLabel *label = new QLabel(tr("Password:"));
    ...
}
//! [0]


//! [1]
void some_global_function(LoginWidget *logwid)
{
    QLabel *label = new QLabel(
                LoginWidget::tr("Password:"), logwid);
}

void same_global_function(LoginWidget *logwid)
{
    QLabel *label = new QLabel(
                QCoreApplication::translate("LoginWidget", "Password:"), logwid);
}
//! [1]


//! [2]
QString FriendlyConversation::greeting(int type)
{
    static const char *greeting_strings[] = {
        QT_TR_NOOP("Hello"),
        QT_TR_NOOP("Goodbye")
    };
    return tr(greeting_strings[type]);
}
//! [2]


//! [3]
static const char *greeting_strings[] = {
    QT_TRANSLATE_NOOP("FriendlyConversation", "Hello"),
    QT_TRANSLATE_NOOP("FriendlyConversation", "Goodbye")
};

QString FriendlyConversation::greeting(int type)
{
    return tr(greeting_strings[type]);
}

QString global_greeting(int type)
{
    return QCoreApplication::translate("FriendlyConversation",
                                       greeting_strings[type]);
}
//! [3]


//! [4]
void FileCopier::showProgress(int done, int total,
                              const QString &currentFile)
{
    label.setText(tr("%1 of %2 files copied.\nCopying: %3")
                  .arg(done)
                  .arg(total)
                  .arg(currentFile));
}
//! [4]


//! [5]
QString s1 = "%1 of %2 files copied. Copying: %3";
QString s2 = "Kopierer nu %3. Av totalt %2 filer er %1 kopiert.";

qDebug() << s1.arg(5).arg(10).arg("somefile.txt");
qDebug() << s2.arg(5).arg(10).arg("somefile.txt");
//! [5]


//! [8]
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QTranslator myappTranslator;
    if (myappTranslator.load(QLocale::system(), u"myapp"_s, u"_"_s, u":/i18n"_s))
        app.installTranslator(&myappTranslator);

    return app.exec();
}
//! [8]


//! [9]
QString string = ...; // some Unicode text

QTextCodec *codec = QTextCodec::codecForName("ISO 8859-5");
QByteArray encodedString = codec->fromUnicode(string);
//! [9]


//! [10]
QByteArray encodedString = ...; // some ISO 8859-5 encoded text

QTextCodec *codec = QTextCodec::codecForName("ISO 8859-5");
QString string = codec->toUnicode(encodedString);
//! [10]


//! [11]
void Clock::setTime(const QTime &time)
{
    if (tr("AMPM") == "AMPM") {
        // 12-hour clock
    } else {
        // 24-hour clock
    }
}
//! [11]


//! [12]
void MyWidget::changeEvent(QEvent *event)
{
    if (event->type() == QEvent::LanguageChange) {
        titleLabel->setText(tr("Document Title"));
        ...
        okPushButton->setText(tr("&OK"));
    } else
        QWidget::changeEvent(event);
}
//! [12]


//! [13]
void some_global_function(LoginWidget *logwid)
{
    QLabel *label = new QLabel(
            LoginWidget::tr("Password:"), logwid);
}

void same_global_function(LoginWidget *logwid)
{
    QLabel *label = new QLabel(
            QCoreApplication::translate("LoginWidget", "Password:"),
            logwid);
}
//! [13]


//! [14]
    QTranslator qtTranslator;
    if (qtTranslator.load(QLocale::system(), u"qtbase"_s, u"_"_s,
                          QLibraryInfo::path(QLibraryInfo::TranslationsPath))) {
        app.installTranslator(&qtTranslator);
    }
//! [14]
