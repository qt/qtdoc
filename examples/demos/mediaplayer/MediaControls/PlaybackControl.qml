// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts
import QtMultimedia
import Config

Item {
    id: root

    implicitHeight: 100

    required property MediaPlayer mediaPlayer
    readonly property int mediaPlayerState: root.mediaPlayer.playbackState
    property bool isPlaylistShuffled: false
    property bool isPlaylistLooped: false
    property bool isPlaylistVisible: false
    property url playlistIcon: !root.isPlaylistVisible ? Config.iconSource("Playlist_Icon") : Config.iconSource("Playlist_Active", false)
    property url shuffleIcon: !root.isPlaylistShuffled ? Config.iconSource("Shuffle_Icon") : Config.iconSource("Shuffle_Active", false)

    property alias volume: audio.volume
    property alias playbackRate: rate.playbackRate
    property alias playlistButton: playlistButton
    property alias menuButton: menuButton

    signal playNextFile()
    signal playPreviousFile()

    function changeLoopMode() {
        if (root.mediaPlayer.loops === 1 && !root.isPlaylistLooped) {
            root.mediaPlayer.loops = MediaPlayer.Infinite
        } else if (root.mediaPlayer.loops === MediaPlayer.Infinite) {
            root.mediaPlayer.loops = 1
            root.isPlaylistLooped = true
        } else {
            root.mediaPlayer.loops = 1
            root.isPlaylistLooped = false
        }
    }

    Item {
        anchors.fill: root

        RowLayout {
            id: playerButtons
            anchors.fill: parent

            Item {
                CustomButton {
                    id: menuButton
                    icon.source: Config.iconSource("Menu_Icon")
                    visible: Config.isMobileTarget
                    anchors.centerIn: parent
                }

                Layout.fillWidth: true
                Layout.minimumWidth: 40
                Layout.maximumWidth: 95
            }

            PlaybackRateControl {
                id: rate
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            Item {
                Layout.fillWidth: true
            }

            RowLayout {
                id: controlButtons
                spacing: Screen.primaryOrientation === Qt.LandscapeOrientation ? 25 : 1

                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true

                CustomButton {
                    id: shuffleButton
                    icon.source: root.shuffleIcon
                    visible: Screen.primaryOrientation === Qt.LandscapeOrientation
                    onClicked: root.isPlaylistShuffled = !root.isPlaylistShuffled
                }

                CustomButton {
                    id: previousButton
                    icon.source: Config.iconSource("Previous_Icon")
                    onClicked: root.playPreviousFile()
                }

                CustomButton {
                    id: playButton
                    icon.source: Config.iconSource("Play_Icon", false)
                    onClicked: root.mediaPlayer.play()
                }

                CustomButton {
                    id: pausedButton
                    icon.source: Config.iconSource("Stop_Icon", false)
                    onClicked: root.mediaPlayer.pause()
                }

                CustomButton {
                    id: nextButton
                    icon.source: Config.iconSource("Next_Icon")
                    onClicked: root.playNextFile()
                }

                CustomButton {
                    id: loopButton
                    icon.source: Config.iconSource("Loop_Icon")
                    visible: Screen.primaryOrientation === Qt.LandscapeOrientation
                    onClicked: root.changeLoopMode()

                    states: [
                        State {
                            name: "noActiveLooping"
                            when: root.mediaPlayer.loops === 1 && !root.isPlaylistLooped
                            PropertyChanges {
                                loopButton.icon.source: Config.iconSource("Loop_Icon")
                            }
                        },
                        State {
                            name: "singleLoop"
                            when: root.mediaPlayer.loops === MediaPlayer.Infinite
                            PropertyChanges {
                                loopButton.icon.source: Config.iconSource("Single_Loop", false)
                            }
                        },
                        State {
                            name: "playlistLoop"
                            when: root.isPlaylistLooped
                            PropertyChanges {
                                loopButton.icon.source: Config.iconSource("Loop_Playlist", false)
                            }
                        }
                    ]
                }
            }

            Item {
                Layout.fillWidth: true
            }

            AudioControl {
                id: audio
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            Item {
                Layout.fillWidth: true
                Layout.minimumWidth:40
                Layout.maximumWidth: 95

                CustomButton {
                    id: playlistButton
                    anchors.centerIn: parent
                    icon.source: root.playlistIcon
                }
            }
        }
    }

    states: [
        State {
            name: "playing"
            when: root.mediaPlayerState == MediaPlayer.PlayingState

            PropertyChanges {
                playButton.visible: false
            }
            PropertyChanges {
                pausedButton.visible: true
            }
        },
        State {
            name: "paused"
            when: root.mediaPlayerState == MediaPlayer.PausedState || root.mediaPlayerState == MediaPlayer.StoppedState

            PropertyChanges {
                playButton.visible: true
            }
            PropertyChanges {
                pausedButton.visible: false
            }
        }
    ]
}

