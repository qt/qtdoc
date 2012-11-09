#include "notepad.h"
#include "ui_notepad.h"

//! [0]
#include <QFileDialog>
#include <QFile>
#include <QMessageBox>
#include <QTextStream>
//! [0]

Notepad::Notepad(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::Notepad)
{
    ui->setupUi(this);
}

Notepad::~Notepad()
{
    delete ui;
}

//! [1]
void Notepad::on_quitButton_clicked()
{
    qApp->quit();
}
//! [1]

//! [2]
void Notepad::on_actionOpen_triggered()
{
    QString fileName = QFileDialog::getOpenFileName(this, tr("Open File"), "",
            tr("Text Files (*.txt);;C++ Files (*.cpp *.h)"));

        if (fileName != "") {
            QFile file(fileName);
            if (!file.open(QIODevice::ReadOnly)) {
                QMessageBox::critical(this, tr("Error"), tr("Could not open file"));
                return;
            }
            QTextStream in(&file);
            ui->textEdit->setText(in.readAll());
            file.close();
        }
}
//! [2]

//! [3]
void Notepad::on_actionSave_triggered()
{
            QString fileName = QFileDialog::getSaveFileName(this, tr("Save File"), "",
            tr("Text Files (*.txt);;C++ Files (*.cpp *.h)"));

            if (fileName != "") {
                QFile file(fileName);
                if (!file.open(QIODevice::WriteOnly)) {
                    // error message
                } else {
                    QTextStream stream(&file);
                    stream << ui->textEdit->toPlainText();
                    stream.flush();
                    file.close();
                }
            }
}
//! [3]
