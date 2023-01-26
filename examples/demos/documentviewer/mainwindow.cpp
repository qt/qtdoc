// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "abstractviewer.h"
#include "viewerfactory.h"
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
    readSettings();
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

    // If a viewer is already open, save its state first
    saveViewerSettings();
    m_viewer.reset(ViewerFactory::makeViewer(file, ui->viewArea, this));
    restoreViewerSettings();

    ui->actionPrint->setEnabled(m_viewer->hasContent());
    connect(m_viewer.get(), &AbstractViewer::printingEnabledChanged, ui->actionPrint, &QAction::setEnabled);
    connect(ui->actionPrint, &QAction::triggered, m_viewer.get(), &AbstractViewer::print);
    connect(m_viewer.get(), &AbstractViewer::showMessage, statusBar(), &QStatusBar::showMessage);

    m_viewer->initViewer(ui->actionBack, ui->actionForward, ui->menuHelp->menuAction(), ui->tabWidget);
    ui->scrollArea->setWidget(m_viewer->widget());
}

void MainWindow::on_actionAbout_triggered()
{
    QMessageBox::aboutQt(this);
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
}

void MainWindow::saveSettings() const
{
    QSettings settings(settingsName);

    // Save working directory
    settings.setValue(settingsDir, m_currentDir.absolutePath());

    // Save QMainWindow state
    settings.setValue(settingsMainWindow, saveState());

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

