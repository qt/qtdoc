// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "pdfviewer.h"
#include "zoomselector.h"
#include "hoverwatcher.h"

#include <QApplication>
#include <QPdfBookmarkModel>
#include <QPdfDocument>
#include <QPdfPageNavigator>
#if QT_VERSION >= QT_VERSION_CHECK(6,6,0)
#include <QPdfPageSelector>
#endif
#include <QListView>
#include <QPdfView>
#include <QStandardPaths>
#include <QtMath>
#include <QSpinBox>
#include <QToolBar>
#include <QMainWindow>
#include <QTreeView>
#include <QListWidget>
#include <QScrollBar>
#include <QEvent>
#include <QMouseEvent>
#include <QScroller>
#ifdef QT_ABSTRACTVIEWER_PRINTSUPPORT
#include <QPrinter>
#include <QPainter>
#endif

Q_LOGGING_CATEGORY(lcExample, "qt.examples.pdfviewer")

PdfViewer::PdfViewer(QFile *file, QWidget *parent, QMainWindow *mainWindow) :
    AbstractViewer(file, new QPdfView(parent), mainWindow), m_document(new QPdfDocument(this))

{
    m_pdfView = qobject_cast<QPdfView *>(widget());
    connect(this, &AbstractViewer::uiInitialized, this, &PdfViewer::initPdfViewer);
}
PdfViewer::~PdfViewer()
{
    delete m_pages;
    delete m_bookmarks;
    delete m_document;
}

void PdfViewer::initPdfViewer()
{
    m_toolBar = addToolBar("PDF");
    m_zoomSelector = new ZoomSelector(m_toolBar);

    auto *nav = m_pdfView->pageNavigator();
#if QT_VERSION >= QT_VERSION_CHECK(6,6,0)
    m_pageSelector = new QPdfPageSelector(m_toolBar);
    m_toolBar->insertWidget(m_uiAssets.forward, m_pageSelector);
    connect(m_pageSelector, &QSpinBox::valueChanged, this, &PdfViewer::pageSelected);
    connect(m_pageSelector, &QSpinBox::valueChanged, this, &PdfViewer::pageSelected);
    connect(nav, &QPdfPageNavigator::currentPageChanged, m_pageSelector, &QSpinBox::setValue);
#endif

    connect(m_pdfView->pageNavigator(), &QPdfPageNavigator::backAvailableChanged, m_uiAssets.back, &QAction::setEnabled);
    m_actionBack = m_uiAssets.back;
    m_actionForward = m_uiAssets.forward;
    connect(m_uiAssets.back, &QAction::triggered, this, &PdfViewer::onActionBackTriggered);
    connect(m_uiAssets.forward, &QAction::triggered, this, &PdfViewer::onActionForwardTriggered);

    m_toolBar->addSeparator();
    m_toolBar->addWidget(m_zoomSelector);

    auto *actionZoomIn = m_toolBar->addAction("Zoom in");
    actionZoomIn->setToolTip("Increase zoom level");
    actionZoomIn->setIcon(QIcon(":/demos/documentviewer/images/zoom-in.png"));
    m_toolBar->addAction(actionZoomIn);
    connect(actionZoomIn, &QAction::triggered, this, &PdfViewer::onActionZoomInTriggered);

    auto *actionZoomOut = m_toolBar->addAction("Zoom out");
    actionZoomOut->setToolTip("Decrease zoom level");
    actionZoomOut->setIcon(QIcon(":/demos/documentviewer/images/zoom-out.png"));
    m_toolBar->addAction(actionZoomOut);
    connect(actionZoomOut, &QAction::triggered, this, &PdfViewer::onActionZoomOutTriggered);

    connect(nav, &QPdfPageNavigator::backAvailableChanged, m_actionBack, &QAction::setEnabled);
    connect(nav, &QPdfPageNavigator::forwardAvailableChanged, m_actionForward, &QAction::setEnabled);

    connect(m_zoomSelector, &ZoomSelector::zoomModeChanged, m_pdfView, &QPdfView::setZoomMode);
    connect(m_zoomSelector, &ZoomSelector::zoomFactorChanged, m_pdfView, &QPdfView::setZoomFactor);
    m_zoomSelector->reset();

    QPdfBookmarkModel *bookmarkModel = new QPdfBookmarkModel(this);
    bookmarkModel->setDocument(m_document);
    m_uiAssets.tabs->clear();
    m_bookmarks = new QTreeView(m_uiAssets.tabs);
    connect(m_bookmarks, &QAbstractItemView::activated, this, &PdfViewer::bookmarkSelected);
    m_bookmarks->setModel(bookmarkModel);
    m_pdfView->setDocument(m_document);
    m_pdfView->setPageMode(QPdfView::PageMode::MultiPage);

    openPdfFile();
    if (!m_document->pageCount())
        return;

    m_pages = new QListView(m_uiAssets.tabs);
    m_pages->setModel(m_document->pageModel());
    connect(m_pages->selectionModel(), &QItemSelectionModel::currentRowChanged, m_pages, [&]
            (const QModelIndex &current, const QModelIndex &previous){
        if (previous == current)
            return;

        auto *nav = m_pdfView->pageNavigator();
        const int &row = current.row();
        if (nav->currentPage() == row)
            return;

        nav->jump(row, QPointF(), nav->currentZoom());
    });

    connect(m_pdfView->pageNavigator(), &QPdfPageNavigator::currentPageChanged, m_pages, [&](int page){
       if (m_pages->currentIndex().row() == page)
           return;

       m_pages->setCurrentIndex(m_pages->model()->index(page, 0));
    });

    m_uiAssets.tabs->addTab(m_pages, "Pages");
    m_uiAssets.tabs->addTab(m_bookmarks, "Bookmarks");
    QScroller::grabGesture(m_pdfView->viewport(), QScroller::ScrollerGestureType::LeftMouseButtonGesture);
    HoverWatcher::watcher(m_pdfView->viewport());
}

void PdfViewer::openPdfFile()
{
    disablePrinting();

    if (m_file->open(QIODevice::ReadOnly))
        m_document->load(m_file.get());

    const auto documentTitle = m_document->metaData(QPdfDocument::MetaDataField::Title).toString();
    statusMessage(!documentTitle.isEmpty() ? documentTitle : QStringLiteral("PDF Viewer"));
    pageSelected(0);
#if QT_VERSION >= QT_VERSION_CHECK(6,6,0)
    m_pageSelector->setMaximum(m_document->pageCount() - 1);
#endif

    statusMessage(tr("Opened PDF file %1").arg(m_file->fileName()));
    qCDebug(lcExample) << "Opened file" << m_file->fileName();

    maybeEnablePrinting();
}

bool PdfViewer::hasContent() const
{
    return m_document ? m_document->pageCount() > 0 : false;
}

#if defined(QT_ABSTRACTVIEWER_PRINTSUPPORT)
void PdfViewer::printDocument(QPrinter *printer) const
{
    if (!hasContent())
        return;

    QPainter painter;
    painter.begin(printer);
    const QRect pageRect = printer->pageRect(QPrinter::Unit::DevicePixel).toRect();
    const QSize pageSize = pageRect.size();
    for (int i = 0; i < m_document->pageCount(); ++i) {
        if (i > 0)
            printer->newPage();
        const QImage &page = m_document->render(i, pageSize);
        painter.drawImage(pageRect, page);
    }
    painter.end();
}
#endif // QT_ABSTRACTVIEWER_PRINTSUPPORT

void PdfViewer::bookmarkSelected(const QModelIndex &index)
{
    if (!index.isValid())
        return;

    const int page = index.data(int(QPdfBookmarkModel::Role::Page)).toInt();
    const qreal zoomLevel = index.data(int(QPdfBookmarkModel::Role::Level)).toReal();
    m_pdfView->pageNavigator()->jump(page, {}, zoomLevel);
}

void PdfViewer::pageSelected(int page)
{
    auto nav = m_pdfView->pageNavigator();
    nav->jump(page, {}, nav->currentZoom());
}

void PdfViewer::onActionZoomInTriggered()
{
    m_pdfView->setZoomFactor(m_pdfView->zoomFactor() * zoomMultiplier);
}

void PdfViewer::onActionZoomOutTriggered()
{
    m_pdfView->setZoomFactor(m_pdfView->zoomFactor() / zoomMultiplier);
}

void PdfViewer::onActionPreviousPageTriggered()
{
    auto nav = m_pdfView->pageNavigator();
    nav->jump(nav->currentPage() - 1, {}, nav->currentZoom());
}

void PdfViewer::onActionNextPageTriggered()
{
    auto nav = m_pdfView->pageNavigator();
    nav->jump(nav->currentPage() + 1, {}, nav->currentZoom());
}

void PdfViewer::onActionBackTriggered()
{
    m_pdfView->pageNavigator()->back();
}

void PdfViewer::onActionForwardTriggered()
{
    m_pdfView->pageNavigator()->forward();
}
