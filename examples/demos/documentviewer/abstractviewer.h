// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef ABSTRACTVIEWER_H
#define ABSTRACTVIEWER_H

#include <QWidget>
#include <QMainWindow>
#include <QFileInfo>

#if defined(QT_PRINTSUPPORT_LIB)
#include <QtPrintSupport/qtprintsupportglobal.h>
#if QT_CONFIG(printer)
#if QT_CONFIG(printdialog)
#define QT_ABSTRACTVIEWER_PRINTSUPPORT
#include <QPrinter>
#endif // QT_CONFIG(printdialog)
#endif // QT_CONFIG(printer)
#endif // QT_PRINTSUPPORT_LIB

class QToolBar;
class QTabWidget;
class QScrollArea;
class QStatusBar;
class AbstractViewer : public QObject
{
    Q_OBJECT

protected:
    explicit AbstractViewer(QFile *file, QWidget *widget, QMainWindow *mainWindow);

public:
    virtual ~AbstractViewer();

    void initViewer(QAction *back, QAction *forward, QAction *help, QTabWidget *tabs);
    virtual bool isModified() const { return false; }
    virtual bool saveDocument() { return false; }
    virtual bool saveDocumentAs() { return false; }
    virtual QString viewerName() const = 0;
    virtual bool supportsOverview() const { return false; }
    virtual QByteArray saveState() const = 0;
    virtual bool restoreState(QByteArray &) = 0;
    virtual bool hasContent() const { return false; }
    bool isEmpty() const { return !hasContent(); }
    bool isPrintingEnabled() const { return m_printingEnabled; }

    QList<QAction *> actions() const { return m_actions; }
    QWidget *widget() const { return m_widget; }
    QList<QMenu *> menus() const { return m_menus; }

#ifdef QT_ABSTRACTVIEWER_PRINTSUPPORT
protected:
    virtual void printDocument(QPrinter *) const {};
#endif

signals:
    void uiInitialized();
    void printingEnabledChanged(bool enabled);
    void showMessage(const QString &message, int timeout = 8000);
    void documentLoaded(const QString &fileName);

public slots:
    void print();

protected:

    struct UiAssets {
        QMainWindow *mainWindow = nullptr;
        QAction *back = nullptr;
        QAction *forward = nullptr;
        QAction *help = nullptr;
        QTabWidget *tabs = nullptr;
    } m_uiAssets;

    void statusMessage(const QString &message, const QString &type = QString(), int timeout = 8000);
    QToolBar *addToolBar(const QString &);
    QMenu *addMenu(const QString &);
    QMenu *fileMenu();
    QMainWindow *mainWindow() const { return m_uiAssets.mainWindow; }
    QStatusBar *statusBar() const { return mainWindow()->statusBar(); }
    QMenuBar *menuBar() const { return mainWindow()->menuBar(); }

    std::unique_ptr<QFile> m_file;
    QList<QAction *> m_actions;
    QWidget *m_widget;

protected slots:
    void maybeSetPrintingEnabled(bool enabled);
    inline void maybeEnablePrinting() { return maybeSetPrintingEnabled(true); }
    inline void disablePrinting() { return maybeSetPrintingEnabled(false); }

private:
    QList<QMenu *> m_menus;
    QList<QToolBar *> m_toolBars;
    bool m_printingEnabled = false;
    int m_classId = -1;

    static constexpr QLatin1StringView m_viewerName = QLatin1StringView("AbstractViewer");
};

#endif // ABSTRACTVIEWER_H
