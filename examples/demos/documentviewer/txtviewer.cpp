// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "txtviewer.h"

#include <QGuiApplication>
#include <QPlainTextEdit>
#include <QTextDocument>
#include <QMenu>
#include <QMenuBar>
#include <QToolBar>
#include <QFileDialog>
#include <QMetaObject>
#include <QScrollBar>
#include <QPainter>
#ifdef QT_ABSTRACTVIEWER_PRINTSUPPORT
#include <QPrinter>
#include <QPrintDialog>
#endif

TxtViewer::TxtViewer(QFile *file, QWidget *parent, QMainWindow *mainWindow) :
        AbstractViewer(file, new QPlainTextEdit(parent), mainWindow)
{
    m_textEdit = qobject_cast<QPlainTextEdit *>(widget());
    connect(this, &AbstractViewer::uiInitialized, this, &TxtViewer::setupTxtUi);
}

TxtViewer::~TxtViewer()
{
}

void TxtViewer::setupTxtUi()
{
    QMenu *editMenu = addMenu(tr("&Edit"));
    QToolBar *editToolBar = addToolBar(tr("Edit"));
#ifndef QT_NO_CLIPBOARD
    const QIcon cutIcon = QIcon::fromTheme("edit-cut", QIcon(":/demos/documentviewer/images/cut.png"));
    QAction *cutAct = new QAction(cutIcon, tr("Cu&t"), this);
    cutAct->setShortcuts(QKeySequence::Cut);
    cutAct->setStatusTip(tr("Cut the current selection's contents to the "
                            "clipboard"));
    connect(cutAct, &QAction::triggered, m_textEdit, &QPlainTextEdit::cut);
    editMenu->addAction(cutAct);
    editToolBar->addAction(cutAct);

    const QIcon copyIcon = QIcon::fromTheme("edit-copy", QIcon(":/demos/documentviewer/images/copy.png"));
    QAction *copyAct = new QAction(copyIcon, tr("&Copy"), this);
    copyAct->setShortcuts(QKeySequence::Copy);
    copyAct->setStatusTip(tr("Copy the current selection's contents to the "
                             "clipboard"));
    connect(copyAct, &QAction::triggered, m_textEdit, &QPlainTextEdit::copy);
    editMenu->addAction(copyAct);
    editToolBar->addAction(copyAct);

    const QIcon pasteIcon = QIcon::fromTheme("edit-paste", QIcon(":/demos/documentviewer/images/paste.png"));
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

void TxtViewer::openFile()
{
    const QString type = tr("open");
    if (!m_file->open(QFile::ReadOnly | QFile::Text)) {
        statusMessage(tr("Cannot read file %1:\n%2.").arg(m_file->fileName(),
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

    statusMessage(tr("File %1 loaded.").arg(m_file->fileName()), type);
    maybeEnablePrinting();
}

bool TxtViewer::hasContent() const
{
    return (!m_textEdit->toPlainText().isEmpty());
}

#if defined(QT_ABSTRACTVIEWER_PRINTSUPPORT)
void TxtViewer::printDocument(QPrinter *printer) const
{
    if (!hasContent())
        return;

    m_textEdit->print(printer);
}

#endif // QT_ABSTRACTVIEWER_PRINTSUPPORT

bool TxtViewer::saveFile(QFile *file)
{
    QString errorMessage;

    QGuiApplication::setOverrideCursor(Qt::WaitCursor);
    if (file->open(QFile::WriteOnly | QFile::Text)) {
        QTextStream out(file);
        out << m_textEdit->toPlainText();
    } else {
        errorMessage = tr("Cannot open file %1 for writing:\n%2.")
                       .arg(file->fileName()), file->errorString();
    }
    QGuiApplication::restoreOverrideCursor();

    if (!errorMessage.isEmpty()) {
        statusMessage(errorMessage);
        return false;
    }

    statusMessage(tr("File %1 saved").arg(file->fileName()));
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
