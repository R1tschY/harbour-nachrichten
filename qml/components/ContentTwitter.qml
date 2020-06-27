import QtQuick 2.0
import Sailfish.Silica 1.0
import "."

MouseArea {
    y: Theme.paddingSmall
    height: Math.max(column.height, image.height) + Theme.paddingSmall * 2
    width: page.width

    Rectangle {
        anchors.fill: parent
        color: "white"
        opacity: 0.1
    }

    Column {
        id: column

        Label {
            text: modelData.social.username
            x: Theme.horizontalPageMargin / 2 + Theme.itemSizeSmall
            width: page.width - Theme.horizontalPageMargin - Theme.itemSizeSmall
            truncationMode: TruncationMode.Fade
            font.pixelSize: Theme.fontSizeSmall
            font.bold: true
            wrapMode: Text.WordWrap
        }

        Label {
            text: "@" + modelData.social.account
            x: Theme.horizontalPageMargin / 2 + Theme.itemSizeSmall
            width: page.width - Theme.horizontalPageMargin - Theme.itemSizeSmall
            truncationMode: TruncationMode.Fade
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.secondaryColor
            wrapMode: Text.WordWrap
        }

        Label {
            text: modelData.social.date
            x: Theme.horizontalPageMargin / 2 + Theme.itemSizeSmall
            width: page.width - Theme.horizontalPageMargin - Theme.itemSizeSmall
            truncationMode: TruncationMode.Fade
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.secondaryColor
            wrapMode: Text.WordWrap
        }

        Label {
            text: modelData.social.shorttext
            x: Theme.horizontalPageMargin
            font.pixelSize: Theme.fontSizeSmall
            //color: Theme.secondaryColor
            width: page.width - Theme.horizontalPageMargin * 2
            //truncationMode: TruncationMode.Fade
            wrapMode: Text.WordWrap
            linkColor: Theme.secondaryColor

            onLinkActivated: Qt.openUrlExternally(link)
        }

        Image {
            source: modelData.social.images.mittel16x9.imageurl
            width: page.width
            height: page.width * 9 / 16
            fillMode: Image.PreserveAspectCrop
            busyIndicatorSize: BusyIndicatorSize.Medium
            visible: !!modelData.social.images.mittel16x9.imageurl
        }
    }

    Image {
        id: image
        y: Theme.paddingSmall
        source: modelData.social.avatar
        width: Theme.itemSizeExtraSmall
        height: Theme.itemSizeExtraSmall
        fillMode: Image.PreserveAspectCrop
        busyIndicatorSize: BusyIndicatorSize.Small
    }

    onClicked: Qt.openUrlExternally(modelData.social.url)
}
