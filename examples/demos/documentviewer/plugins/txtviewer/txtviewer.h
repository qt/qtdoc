// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef TXTVIEWER_H
#define TXTVIEWER_H

#include "viewerinterfaces.h"
#include "abstractviewer.h"
#include <QPointer>

QT_BEGIN_NAMESPACE
class QMainWindow;
class QPlainTextEdit;
class QLabel;
QT_END_NAMESPACE

class TxtViewer : public ViewerInterface
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.Examples.DocumentViewer.ViewerInterface" FILE "txtviewer.json")
    Q_INTERFACES(ViewerInterface)
public:
    ~TxtViewer() override;
    void init(QFile *file, QWidget *parent, QMainWindow *mainWindow) override;
    QString viewerName() const override { return staticMetaObject.className(); };
    QStringList supportedMimeTypes() const override;
    bool saveDocument() override { return saveFile(m_file.get()); };
    bool saveDocumentAs() override;
    bool hasContent() const override;
    QByteArray saveState() const override { return QByteArray(); }
    bool restoreState(QByteArray &) override { return true; }
    bool supportsOverview() const override { return false; }

#ifdef QT_DOCUMENTVIEWER_PRINTSUPPORT
protected:
    void printDocument(QPrinter *printer) const override;
#endif // QT_DOCUMENTVIEWER_PRINTSUPPORT

private slots:
    void setupTxtUi();

private:
    void openFile();
    bool saveFile (QFile *file);

    int m_classId;
    QPlainTextEdit *m_textEdit;
};

#endif //TXTVIEWER_H