/****************************************************************************
**
** Copyright (C) 2021 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
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

import QtQuick

Grid {
    columns: 3
    columnSpacing: 32
    rowSpacing: 16

    function updateDimmed(){
        for (let i = 0; i < children.length; i++){
            children[i].dimmed = window.isButtonDisabled(children[i].text)
        }
    }

    component DigitButton: CalculatorButton {
        onPressed: function() {
            window.digitPressed(text)
            updateDimmed()
        }
    }

    component OperatorButton: CalculatorButton {
        onPressed: function() {
            window.operatorPressed(text)
            updateDimmed()
        }
        textColor: "#6da43d"
        dimmable: true
    }

    DigitButton {
        text: "7"
    }
    DigitButton {
        text: "8"
    }
    DigitButton {
        text: "9"
    }
    DigitButton {
        text: "4"
    }
    DigitButton {
        text: "5"
    }
    DigitButton {
        text: "6"
    }
    DigitButton {
        text: "1"
    }
    DigitButton {
        text: "2"
    }
    DigitButton {
        text: "3"
    }
    DigitButton {
        text: "0"
    }
    DigitButton {
        text: "."
        dimmable: true
    }
    DigitButton {
        text: " "
    }
    OperatorButton {
        text: "±"
    }
    OperatorButton {
        text: "−"
    }
    OperatorButton {
        text: "+"
    }
    OperatorButton {
        text: "√"
    }
    OperatorButton {
        text: "÷"
    }
    OperatorButton {
        text: "×"
    }
    OperatorButton {
        text: "C"
    }
    OperatorButton {
        text: " "
    }
    OperatorButton {
        text: "="
    }

    Component.onCompleted: updateDimmed()
}
