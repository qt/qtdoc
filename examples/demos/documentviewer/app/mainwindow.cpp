// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "viewerfactory.h"
#include "abstractviewer.h"
#include "recentfiles.h"
#include "recentfilemenu.h"
#include <QFileDialog>
#include <QSettings>
#include <QToolButton>
#include <QMessageBox>
#include <QMetaObject>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    m_recentFiles.reset(new RecentFiles(ui->actionRecent));
    connect(m_recentFiles.get(), &RecentFiles::countChanged, this, [&](int count){
        ui->actionRecent->setText(QString("%1 recent files").arg(count));
    });

    readSettings();
    m_factory.reset(new ViewerFactory(ui->viewArea, this));
    const QStringList &viewers = m_factory->viewerNames();
    const QString msg = tr("Available viewers: ") + viewers.join(", ");
    statusBar()->showMessage(msg);

    auto *menu = new RecentFileMenu(this, m_recentFiles.get());
    ui->actionRecent->setMenu(menu);
    connect(menu, &RecentFileMenu::fileOpened, this, &MainWindow::openFile);
    QWidget *w = ui->mainToolBar->widgetForAction(ui->actionRecent);
    auto *button = qobject_cast<QToolButton *>(w);
    if (button)
        connect(ui->actionRecent, &QAction::triggered, button, &QToolButton::showMenu);
}

MainWindow::~MainWindow()
{
    saveSettings();
}

void MainWindow::on_actionOpen_triggered()
{
    const QString fileName = QFileDialog::getOpenFileName(this,
                                                          tr("Open Document"),
                                                          m_currentDir.absolutePath());

    if (fileName.isEmpty())
        return;

    openFile(fileName);
}

void MainWindow::openFile(const QString &fileName)
{
    QFile *file = new QFile(fileName);
    if (!file->exists()) {
        statusBar()->showMessage(tr("File %1 could not be opened").arg(fileName));
        delete file;
        return;
    }

    QFileInfo fileInfo(*file);
    m_currentDir = fileInfo.dir();
    m_recentFiles->addFile(fileInfo.absoluteFilePath());

    // If a viewer is already open, save its state first
    saveViewerSettings();
    m_viewer = m_factory->viewer(file);
    if (!m_viewer) {
        statusBar()->showMessage(tr("File %1 can't be opened.").arg(fileName));
        return;
    }

    ui->actionPrint->setEnabled(m_viewer->hasContent());
    connect(m_viewer, &AbstractViewer::printingEnabledChanged, ui->actionPrint, &QAction::setEnabled);
    connect(ui->actionPrint, &QAction::triggered, m_viewer, &AbstractViewer::print);
    connect(m_viewer, &AbstractViewer::showMessage, statusBar(), &QStatusBar::showMessage);

    m_viewer->initViewer(ui->actionBack, ui->actionForward, ui->menuHelp->menuAction(), ui->tabWidget);
    restoreViewerSettings();
    ui->scrollArea->setWidget(m_viewer->widget());
}

void MainWindow::on_actionAbout_triggered()
{
    static const QString &text = [&]{
        QString text = tr("A Widgets application to display and print JSON, "
                          "text and PDF files. Demonstrates various features to use "
                          "in widget applications: Using QSettings, query and save "
                          "user preferences, manage file histories and control cursor "
                          "behavior when hovering over widgets.\n\n"
                          "This version has loaded the following plugins:\n") +
                          m_factory->viewerNames().join(", ") +
                          tr("\n\nIt supports thow following mime types:\n") +
                          m_factory->supportedMimeTypes().join("\n");

        AbstractViewer *def = m_factory->defaultViewer();
        if (def) {
            text += tr("\n\nOther mime types will be displayed with ") + def->viewerName() + ".";
        }

        return text;
    }();

    QMessageBox::about(this, tr("About Document Viewer Demo"), text);
}

void MainWindow::on_actionAboutQt_triggered()
{
    QMessageBox::aboutQt(this);
}

void MainWindow::readSettings()
{
    QSettings settings(settingsName);

    // Restore working directory
    if (settings.contains(settingsDir))
        m_currentDir = QDir(settings.value(settingsDir).toString());
    else
        m_currentDir = QDir::current();

    // Restore QMainWindow state
    if (settings.contains(settingsMainWindow)) {
        QByteArray mainWindowState = settings.value(settingsMainWindow).toByteArray();
        restoreState(mainWindowState);
    }

    // Restore recent files
    m_recentFiles->restoreFromSettings(settings, settingsFiles);
}

void MainWindow::saveSettings() const
{
    QSettings settings(settingsName);

    // Save working directory
    settings.setValue(settingsDir, m_currentDir.absolutePath());

    // Save QMainWindow state
    settings.setValue(settingsMainWindow, saveState());

    // Save recent files
    m_recentFiles->saveSettings(settings, settingsFiles);

    settings.sync();
}

void MainWindow::saveViewerSettings() const
{
    if (!m_viewer)
        return;

    QSettings settings(settingsName);
    settings.beginGroup(settingsViewers);
        settings.setValue(m_viewer->viewerName(), m_viewer->saveState());
    settings.endGroup();
    settings.sync();
}

void MainWindow::restoreViewerSettings()
{
    if (!m_viewer)
        return;

    QSettings settings(settingsName);
    settings.beginGroup(settingsViewers);
    QByteArray viewerSettings = settings.value(m_viewer->viewerName(), QByteArray()).toByteArray();
    settings.endGroup();
    if (!viewerSettings.isEmpty())
        m_viewer->restoreState(viewerSettings);
}

