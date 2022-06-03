// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
//Proxies a SoundEffect if QtMultimedia is installed
Item {
    id: container
    property QtObject effect: Qt.createQmlObject("import QtMultimedia; SoundEffect{ source: '" + container.source + "'; muted: Qt.application.state != Qt.ApplicationActive }",container);
    property url source: ""
    onSourceChanged: if (effect != null) effect.source = source;
    function play() {
        if (effect != null)
            effect.play();
    }
}
