// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

Rectangle {
    color: "#d6d6d6"
    width: parent.width
    height: childrenRect.height
    z: 2
    Connections {
        target: mainListView
        function onAutoSearch() {
            if (type == 'tag') {
                tagSearch.open()
                tagSearch.searchText = str
            } else if (type == 'user'){
                userSearch.open()
                userSearch.searchText = str
            } else {
                wordSearch.open()
                wordSearch.searchText = str
            }
        }
    }

    Column {
        width: parent.width

        SearchDelegate {
            id: wordSearch
            label: "Search word..."
            placeHolder: "Enter word"
            onHasOpened: {
                tagSearch.close()
                userSearch.close()
            }
            onOk: {
                mainListView.positionViewAtBeginning()
                mainListView.clear()
                tweetsModel.from = ""
                tweetsModel.phrase = searchText
            }
        }

        SearchDelegate {
            id: userSearch
            label: "From user..."
            placeHolder: "@username"
            prefix: "@"
            onHasOpened:{
                tagSearch.close()
                wordSearch.close()
            }
            onOk: {
                mainListView.positionViewAtBeginning()
                mainListView.clear()
                tweetsModel.phrase = ""
                tweetsModel.from = searchText
            }
        }

        SearchDelegate {
            id: tagSearch
            label: "Search hashtag..."
            placeHolder: "#hashtag"
            prefix: "#"
            onHasOpened:{
                userSearch.close()
                wordSearch.close()
            }
            onOk: {
                mainListView.positionViewAtBeginning()
                mainListView.clear()
                tweetsModel.from = ""
                tweetsModel.phrase = "#" + searchText
            }
        }

        SpriteSequence {
            id: sprite
            anchors.horizontalCenter: parent.horizontalCenter
            width: 320
            height: 300
            running: true
            interpolate: false
            Sprite {
                name: "bird"
                source: "resources/bird-anim-sprites.png"
                frameCount: 1
                frameRate: 1
                frameWidth: 320
                frameHeight: 300
                to: { "bird":10, "trill":1, "blink":1 }
            }
            Sprite {
                name: "trill"
                source: "resources/bird-anim-sprites.png"
                frameCount: 5
                frameRate: 3
                frameWidth: 320
                frameHeight: 300
                to: {"bird":1}
            }
            Sprite {
                name: "blink"
                source: "resources/bird-anim-sprites.png"
                frameCount: 1
                frameRate: 3
                frameWidth: 320
                frameHeight: 300
                frameX: 1600
                to: {"bird":1}
            }
        }
    }
}
