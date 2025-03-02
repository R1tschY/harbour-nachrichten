import QtQuick 2.0
import Sailfish.Silica 1.0
import "."

Column {
    width: page.width

    property var firstImage: modelData.gallery[0]

    NImage {
        spec: modelData.gallery[0]
        size: "16x9-" + width
        width: page.width
        height: page.width * 9 / 16
    }

    TextBlock {
        id: imageTitle
        text: firstImage.title ? firstImage.title : ""
        font.pixelSize: Theme.fontSizeSmall
        bottomPadding: Theme.paddingSmall
        visible: !!text

        Rectangle {
            height: imageTitle.height
            color: "white"
            opacity: 0.3
            anchors.fill: parent
        }
    }
}
