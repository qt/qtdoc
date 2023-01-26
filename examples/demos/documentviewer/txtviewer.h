// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef TXTVIEWER_H
#define TXTVIEWER_H

#include "abstractviewer.h"
#include <QPointer>

class QMainWindow;
class QPlainTextEdit;
class QLabel;
class TxtViewer : public AbstractViewer
{
public:
    TxtViewer(QFile *file, QWidget *parent, QMainWindow *mainWindow);
    ~TxtViewer() override;
    QString viewerName() const override { return staticMetaObject.className(); };
    bool saveDocument() override { return saveFile(m_file.get()); };
    bool saveDocumentAs() override;
    bool hasContent() const override;
    QByteArray saveState() const override { return QByteArray(); }
    bool restoreState(QByteArray &) override { return true; }

#if defined(QT_ABSTRACTVIEWER_PRINTSUPPORT)
protected:
    void printDocument(QPrinter *printer) const override;
#endif // QT_ABSTRACTVIEWER_PRINTSUPPORT

private slots:
    void setupTxtUi();
    void documentWasModified();

private:
    void openFile();
    bool saveFile (QFile *file);

    int m_classId;
    QPlainTextEdit *m_textEdit;
};

#endif //TXTVIEWER_H
