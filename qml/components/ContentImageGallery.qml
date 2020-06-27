import QtQuick 2.0
import Sailfish.Silica 1.0
import "."

Column {
    width: page.width

    property var firstImage: modelData.gallery[0]

    Image {
        source: firstImage.videowebm.imageurl // TODO: other images?
        width: page.width
        height: page.width * 9 / 16
    }

    TextBlock {
        id: imageTitle
        text: firstImage.title
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
