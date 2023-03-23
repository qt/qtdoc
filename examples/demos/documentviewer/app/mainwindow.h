// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QDir>
#include <QFileInfo>
#include <QStringLiteral>

class AbstractViewer;
class RecentFiles;
class ViewerFactory;
namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

public slots:
    void openFile(const QString &fileName);

private slots:
    void on_actionOpen_triggered();
    void on_actionAbout_triggered();
    void on_actionAboutQt_triggered();

private:
    void readSettings();
    void saveSettings() const;
    void restoreViewerSettings();
    void saveViewerSettings() const;

    QDir m_currentDir;
    AbstractViewer *m_viewer = nullptr;
    std::unique_ptr<Ui::MainWindow> ui;
    std::unique_ptr<RecentFiles> m_recentFiles;
    int m_classId = -1;
    std::unique_ptr<ViewerFactory> m_factory;

    static constexpr QLatin1StringView settingsName = QLatin1StringView("DocumentViewerExample");
    static constexpr QLatin1StringView settingsDir = QLatin1StringView("WorkingDir");
    static constexpr QLatin1StringView settingsMainWindow = QLatin1StringView("MainWindow");
    static constexpr QLatin1StringView settingsViewers = QLatin1StringView("Viewers");
    static constexpr QLatin1StringView settingsFiles = QLatin1StringView("RecentFiles");
};

#endif // MAINWINDOW_H
