/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the documentation of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "documenthandler.h"

DocumentHandler::DocumentHandler(QObject *parent) :
    QObject(parent)
{
}

/*
 * Returns the current file's URL.
 */
QUrl DocumentHandler::fileUrl() const
{
    return m_fileUrl;
}

/*
 * Returns the currently opened document's content.
 */
QString DocumentHandler::text() const
{
    return m_text;
}

/*
 * Returns the currently opened document's title.
 */
QString DocumentHandler::documentTitle() const
{
    return m_documentTitle;
}

/*
 * Saves the current content with the given file URL.
 */
void DocumentHandler::saveFile(const QUrl &arg) const
{
    QFile file(arg.toLocalFile());
    if (file.open(QFile::WriteOnly | QFile::Truncate)) {
        QTextStream out(&file);
        out << text();
    }
}

/*
 * Sets the file's URL. Called when a file is opened.
 */
void DocumentHandler::setFileUrl(const QUrl &arg)
{
    if (m_fileUrl != arg) {
        m_fileUrl = arg;
        QString fileName = arg.fileName();
        QFile file(arg.toLocalFile());
        if (file.open(QFile::ReadOnly)) {
            setText(QString(file.readAll()));
            if (fileName.isEmpty())
                m_documentTitle = QStringLiteral("untitled");
            else
                m_documentTitle = fileName;
            emit textChanged();
            emit documentTitleChanged();
        }
        emit fileUrlChanged();
    }
}

/*!
 * Sets the currently opened document's content.
 *
 */
void DocumentHandler::setText(const QString &arg)
{
    m_text = arg;
    emit textChanged();
}

/*
 *  Sets the currently opened document's title.
 */
void DocumentHandler::setDocumentTitle(QString arg)
{
    m_documentTitle = arg;
    emit documentTitleChanged();
}
