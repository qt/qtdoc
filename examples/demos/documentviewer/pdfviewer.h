// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef PDFVIEWER_H
#define PDFVIEWER_H

#include "abstractviewer.h"
#include <QLoggingCategory>

Q_DECLARE_LOGGING_CATEGORY(lcExample)

class QMainWindow;
class QPdfDocument;
class QPdfView;
class QPdfPageSelector;
class QListView;
class QTabWidget;
class QTreeView;
class ZoomSelector;
class PdfViewer : public AbstractViewer
{
public:
    PdfViewer(QFile *file, QWidget *parent, QMainWindow *mainWindow);

    ~PdfViewer() override;
    QString viewerName() const override { return staticMetaObject.className(); };
    bool supportsOverview() const override { return true; }
    bool hasContent() const override;
    QByteArray saveState() const override { return QByteArray(); }
    bool restoreState(QByteArray &) override { return true; }

#if defined(QT_ABSTRACTVIEWER_PRINTSUPPORT)
protected:
    void printDocument(QPrinter *printer) const override;
#endif // QT_ABSTRACTVIEWER_PRINTSUPPORT

public slots:
    void openPdfFile();

private slots:
    void initPdfViewer();
    void bookmarkSelected(const QModelIndex &index);
    void pageSelected(int page);

    // action handlers
    void onActionOpenTriggered();
    void onActionQuitTriggered();
    void onActionZoomInTriggered();
    void onActionZoomOutTriggered();
    void onActionPreviousPageTriggered();
    void onActionNextPageTriggered();
    void onActionBackTriggered();
    void onActionForwardTriggered();

private:
    void populateQuestions();

    const qreal zoomMultiplier = qSqrt(2.0);
    static constexpr int maxIconWidth = 200;
    QToolBar *m_toolBar = nullptr;
    ZoomSelector *m_zoomSelector;
    QPdfPageSelector *m_pageSelector;
    QPdfDocument *m_document;
    QPdfView *m_pdfView;
    QAction *m_actionForward = nullptr;
    QAction *m_actionBack = nullptr;
    QTreeView *m_bookmarks = nullptr;
    QListView *m_pages = nullptr;
};

#endif //PDFVIEWER_H
