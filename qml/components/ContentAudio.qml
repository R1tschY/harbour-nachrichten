import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import "."

Item {
    height: image.height + titleColumn.height

    readonly property bool _loading:
        audioplayer.error === MediaPlayer.NoError
        && (audioplayer.status === MediaPlayer.Buffering
            || audioplayer.status === MediaPlayer.Stalled
            || audioplayer.status === MediaPlayer.Loading
            || audioplayer.status === MediaPlayer.Loaded)

    NImage {
        id: image

        spec: modelData.teaserImage
        size: "16x9-" + width
        width: page.width
        height: page.width * 9 / 16

        MouseArea {
            id: playButtonArea
            anchors.fill: parent
            onClicked: {
                if (audioplayer.playbackState === MediaPlayer.PausedState
                        || audioplayer.playbackState === MediaPlayer.StoppedState) {
                    audioplayer.play()
                } else {
                    audioplayer.pause()
                }
            }
        }

        Rectangle {
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: Theme.horizontalPageMargin
            }

            color: Theme.highlightBackgroundColor
            opacity: 0.75
            width: Theme.itemSizeLarge
            height: Theme.itemSizeLarge
            radius: 15
        }

        Image {
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: Theme.horizontalPageMargin + 7
            }

            width: Theme.iconSizeLarge
            height: Theme.iconSizeLarge
            source: audioplayer.playbackState !== MediaPlayer.PlayingState
                ? "image://theme/icon-m-headphone" : "image://theme/icon-l-pause"

            BusyIndicator {
                anchors.centerIn: parent
                running: _loading
                size: BusyIndicatorSize.Large
            }
        }

        Slider {
            id: positionSlider
            width: parent.width
            anchors.bottom: parent.bottom
            //enabled: false
            handleVisible: false
            maximumValue: audioplayer.duration > 0 ? audioplayer.duration : 1
            value: audioplayer.position

            Timer {
                interval: 1000
                repeat: true
                running: audioplayer.playbackState === MediaPlayer.PlayingState
                onTriggered: positionSlider.value = audioplayer.position
            }
        }
    }

    Rectangle {
        anchors.fill: titleColumn
        color: "white"
        opacity: 0.3
    }

    Column {
        id: titleColumn
        y: image.height

        TextBlock {
            text: modelData.title
            font.pixelSize: Theme.fontSizeMedium
            font.bold: true
        }

        TextBlock {
            text: modelData.text
            font.pixelSize: Theme.fontSizeSmall
        }
    }

    Audio {
        id: audioplayer
        source: modelData.stream
        autoLoad: false

        onPlaybackStateChanged: positionSlider.value = audioplayer.position
    }
}
