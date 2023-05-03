// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

//! [init]
#include "txtviewer.h"

#include <QFileDialog>
#include <QMainWindow>
#include <QMenu>
#include <QMenuBar>
#include <QPlainTextEdit>
#include <QScrollBar>
#include <QToolBar>

#include <QGuiApplication>
#include <QPainter>
#include <QTextDocument>

#include <QDir>

#ifdef QT_DOCUMENTVIEWER_PRINTSUPPORT
#include <QPrinter>
#include <QPrintDialog>
#endif

using namespace Qt::StringLiterals;

TxtViewer::TxtViewer()
{
    connect(this, &AbstractViewer::uiInitialized, this, &TxtViewer::setupTxtUi);
}

TxtViewer::~TxtViewer() = default;

void TxtViewer::init(QFile *file, QWidget *parent, QMainWindow *mainWindow)
{
    AbstractViewer::init(file, new QPlainTextEdit(parent), mainWindow);
    m_textEdit = qobject_cast<QPlainTextEdit *>(widget());
}

QStringList TxtViewer::supportedMimeTypes() const
{
    return {"text/plain"_L1};
}

void TxtViewer::setupTxtUi()
{
    QMenu *editMenu = addMenu(tr("&Edit"));
    QToolBar *editToolBar = addToolBar(tr("Edit"));
#ifndef QT_NO_CLIPBOARD
    const QIcon cutIcon = QIcon::fromTheme("edit-cut"_L1,
                                           QIcon(":/demos/documentviewer/images/cut.png"_L1));
    QAction *cutAct = new QAction(cutIcon, tr("Cu&t"), this);
    cutAct->setShortcuts(QKeySequence::Cut);
    cutAct->setStatusTip(tr("Cut the current selection's contents to the "
                            "clipboard"));
    connect(cutAct, &QAction::triggered, m_textEdit, &QPlainTextEdit::cut);
    editMenu->addAction(cutAct);
    editToolBar->addAction(cutAct);

    const QIcon copyIcon = QIcon::fromTheme("edit-copy"_L1,
                                            QIcon(":/demos/documentviewer/images/copy.png"_L1));
    QAction *copyAct = new QAction(copyIcon, tr("&Copy"), this);
    copyAct->setShortcuts(QKeySequence::Copy);
    copyAct->setStatusTip(tr("Copy the current selection's contents to the "
                             "clipboard"));
    connect(copyAct, &QAction::triggered, m_textEdit, &QPlainTextEdit::copy);
    editMenu->addAction(copyAct);
    editToolBar->addAction(copyAct);

    const QIcon pasteIcon = QIcon::fromTheme("edit-paste"_L1,
                                             QIcon(":/demos/documentviewer/images/paste.png"_L1));
    QAction *pasteAct = new QAction(pasteIcon, tr("&Paste"), this);
    pasteAct->setShortcuts(QKeySequence::Paste);
    pasteAct->setStatusTip(tr("Paste the clipboard's contents into the current "
                              "selection"));
    connect(pasteAct, &QAction::triggered, m_textEdit, &QPlainTextEdit::paste);
    editMenu->addAction(pasteAct);
    editToolBar->addAction(pasteAct);

    menuBar()->addSeparator();

    cutAct->setEnabled(false);
    copyAct->setEnabled(false);
    connect(m_textEdit, &QPlainTextEdit::copyAvailable, cutAct, &QAction::setEnabled);
    connect(m_textEdit, &QPlainTextEdit::copyAvailable, copyAct, &QAction::setEnabled);
#endif // !QT_NO_CLIPBOARD

    openFile();

    connect(m_textEdit, &QPlainTextEdit::textChanged, this, [&](){
        maybeSetPrintingEnabled(hasContent());
    });

    connect(m_uiAssets.back, &QAction::triggered, m_textEdit, [&](){
        auto *bar = m_textEdit->verticalScrollBar();
        if (bar->value() > bar->minimum())
            bar->setValue(bar->value() - 1);
    });

    connect(m_uiAssets.forward, &QAction::triggered, m_textEdit, [&](){
        auto *bar = m_textEdit->verticalScrollBar();
        if (bar->value() < bar->maximum())
            bar->setValue(bar->value() + 1);
    });
}
//! [init]

//! [open]
void TxtViewer::openFile()
{
    const QString type = tr("open");
    if (!m_file->open(QFile::ReadOnly | QFile::Text)) {
        statusMessage(tr("Cannot read file %1:\n%2.")
                      .arg(QDir::toNativeSeparators(m_file->fileName()),
                           m_file->errorString()), type);
        return;
    }

    QTextStream in(m_file.get());
#ifndef QT_NO_CURSOR
    QGuiApplication::setOverrideCursor(Qt::WaitCursor);
#endif
    if (!m_textEdit->toPlainText().isEmpty()) {
        m_textEdit->clear();
        disablePrinting();
    }
    m_textEdit->setPlainText(in.readAll());
#ifndef QT_NO_CURSOR
    QGuiApplication::restoreOverrideCursor();
#endif

    statusMessage(tr("File %1 loaded.")
                  .arg(QDir::toNativeSeparators(m_file->fileName())), type);
    maybeEnablePrinting();
}
//! [open]

//! [infoPrintAndSave]
bool TxtViewer::hasContent() const
{
    return (!m_textEdit->toPlainText().isEmpty());
}

#ifdef QT_DOCUMENTVIEWER_PRINTSUPPORT
void TxtViewer::printDocument(QPrinter *printer) const
{
    if (!hasContent())
        return;

    m_textEdit->print(printer);
}
#endif // QT_DOCUMENTVIEWER_PRINTSUPPORT

bool TxtViewer::saveFile(QFile *file)
{
    QString errorMessage;

    QGuiApplication::setOverrideCursor(Qt::WaitCursor);
    if (file->open(QFile::WriteOnly | QFile::Text)) {
        QTextStream out(file);
        out << m_textEdit->toPlainText();
    } else {
        errorMessage = tr("Cannot open file %1 for writing:\n%2.")
                       .arg(QDir::toNativeSeparators(file->fileName())),
                            file->errorString();
    }
    QGuiApplication::restoreOverrideCursor();

    if (!errorMessage.isEmpty()) {
        statusMessage(errorMessage);
        return false;
    }

    statusMessage(tr("File %1 saved")
                  .arg(QDir::toNativeSeparators(file->fileName())));
    return true;
}

bool TxtViewer::saveDocumentAs()
{
    QFileDialog dialog(mainWindow());
    dialog.setWindowModality(Qt::WindowModal);
    dialog.setAcceptMode(QFileDialog::AcceptSave);
    if (dialog.exec() != QDialog::Accepted)
        return false;

    const QStringList &files = dialog.selectedFiles();
    if (files.isEmpty())
        return false;

    //newFile();
    m_file->setFileName(files.first());
    return saveDocument();
}
//! [infoPrintAndSave]
