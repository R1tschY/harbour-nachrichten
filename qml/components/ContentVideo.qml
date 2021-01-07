import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0

Column {
    width: page.width

    readonly property bool _noMedia:
        mediaplayer.status === MediaPlayer.EndOfMedia
        || mediaplayer.status === MediaPlayer.InvalidMedia
        || mediaplayer.status === MediaPlayer.UnknownStatus
        || mediaplayer.status === MediaPlayer.NoMedia
        || mediaplayer.status === MediaPlayer.Loading
    readonly property bool _loading:
        mediaplayer.error === MediaPlayer.NoError
        && (mediaplayer.status === MediaPlayer.Buffering
            || mediaplayer.status === MediaPlayer.Stalled
            || mediaplayer.status === MediaPlayer.Loading
            || mediaplayer.status === MediaPlayer.Loaded)

    Item {
        width: page.width
        height: page.width * 9 / 16

        Image {
            anchors.fill: parent
            source: modelData.video.teaserImage.videowebm.imageurl
            visible: _noMedia
        }

        VideoOutput {
            anchors.fill: parent
            source: mediaplayer
            visible: !_noMedia
        }

        MediaPlayer {
            id: mediaplayer
            //audioRole: MediaPlayer.VideoRole
            source: modelData.video.streams.adaptivestreaming
            autoLoad: false

            Component.onCompleted: {
                console.debug("status " + mediaplayer.status + " " + MediaPlayer.NoMedia)
            }

            onStatusChanged: {
                switch (status) {
                case MediaPlayer.Buffering:
                    console.debug("buffering")
                    break
                case MediaPlayer.Stalled:
                    console.debug("stalled")
                    break
                case MediaPlayer.Buffered:
                    console.debug("buffered")
                    break
                case MediaPlayer.EndOfMedia:
                    console.debug("end of media")
                    break
                case MediaPlayer.Loaded:
                    console.debug("loaded")
                    break
                case MediaPlayer.InvalidMedia:
                    console.debug("invalid media")
                    break
                case MediaPlayer.NoMedia:
                    console.debug("no media")
                    break
                case MediaPlayer.Loading:
                    console.debug("loading")
                    break
                case MediaPlayer.UnknownStatus:
                    console.debug("unknown status")
                    break
                default:
                    console.debug("unhandled status")
                    break
                }
            }

            onPlaybackStateChanged: {
                switch (playbackState) {
                case MediaPlayer.PlayingState:
                    console.debug("playing")
                    break
                case MediaPlayer.PausedState:
                    console.debug("paused")
                    break
                case MediaPlayer.StoppedState:
                    console.debug("stopped")
                    break
                default:
                    console.debug("unhandled playback state")
                    break
                }
            }

            onErrorChanged: {
                switch (error) {
                case MediaPlayer.NoError:
                    console.debug("no error")
                    break
                case MediaPlayer.ResourceError:
                    console.debug("resource error")
                    break
                case MediaPlayer.FormatError:
                    console.debug("format error")
                    break
                case MediaPlayer.NetworkError:
                    console.debug("network error")
                    break
                case MediaPlayer.AccessDenied:
                    console.debug("access denied error")
                    break
                case MediaPlayer.ServiceMissing:
                    console.debug("service missing error")
                    break
                default:
                    console.debug("unhandled error")
                    break
                }
            }
        }

        BusyIndicator {
            anchors.centerIn: parent
            running: _loading
            size: BusyIndicatorSize.Large
        }

        MouseArea {
            id: playArea
            anchors.fill: parent
            onPressed: {
                if (mediaplayer.playbackState === MediaPlayer.PlayingState) {
                    mediaplayer.pause()
                }
            }
        }

        Rectangle {
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }

            color: Theme.highlightBackgroundColor
            visible: mediaplayer.playbackState !== MediaPlayer.PlayingState
            opacity: 0.75
            width: Theme.itemSizeLarge
            height: Theme.itemSizeLarge
            radius: 15

            MouseArea {
                id: playButtonArea
                anchors.fill: parent
                onPressed: {
                    if (mediaplayer.playbackState === MediaPlayer.PausedState
                            || mediaplayer.playbackState === MediaPlayer.StoppedState) {
                        mediaplayer.play()
                    }
                }
            }
        }

        Image {
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }

            width: Theme.iconSizeLarge
            height: Theme.iconSizeLarge
            source: "image://theme/icon-l-play"
            visible: mediaplayer.playbackState !== MediaPlayer.PlayingState
        }
    }


    TextBlock {
        id: imageTitle
        text: modelData.video.title
        font.pixelSize: Theme.fontSizeSmall
        bottomPadding: Theme.paddingSmall

        Rectangle {
            height: imageTitle.height
            color: "white"
            opacity: 0.3
            anchors.fill: parent
        }
    }
}
