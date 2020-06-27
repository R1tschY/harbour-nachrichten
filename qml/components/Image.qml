import QtQuick 2.0
import Sailfish.Silica 1.0

Image {
    id: image

    property var sourceRef

    property alias busyIndicatorSize: indicator.size

    source: sourceRef ? sourceRef.videowebs.imageurl : ""
    asynchronous: true

    // TODO: use image.progress
    BusyIndicator {
        id: indicator
        size: BusyIndicatorSize.Small
        anchors.centerIn: image
        running: image.status === Image.Loading
    }
}
