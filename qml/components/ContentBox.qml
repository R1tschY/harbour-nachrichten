import QtQuick 2.0
import Sailfish.Silica 1.0
import "."

MouseArea {
    y: Theme.paddingSmall
    height: Math.max(column.height, image.height) + Theme.paddingSmall * 2
    width: page.width

    readonly property bool hasImage: !!modelData.box.images
    readonly property int imageSize: hasImage ? Theme.itemSizeSmall : (Theme.horizontalPageMargin / 2)

    Rectangle {
        anchors.fill: parent
        color: "white"
        opacity: 0.1
    }

    Column {
        id: column
        x: Theme.horizontalPageMargin / 2 + imageSize

        Label {
            text: modelData.box.subtitle || ""
            width: page.width - Theme.horizontalPageMargin - imageSize
            truncationMode: TruncationMode.Fade
            font.pixelSize: Theme.fontSizeSmall * 0.9
            color: Theme.secondaryColor
            visible: !!modelData.box.subtitle
        }

        Label {
            text: modelData.box.title
            width: page.width - Theme.horizontalPageMargin - imageSize
            truncationMode: TruncationMode.Fade
            font.pixelSize: Theme.fontSizeMedium
            font.bold: true
            wrapMode: Text.WordWrap
        }

        Label {
            text: modelData.box.text
            font.pixelSize: Theme.fontSizeSmall
            //color: Theme.secondaryColor
            width: page.width - Theme.horizontalPageMargin - imageSize
            //truncationMode: TruncationMode.Fade
            wrapMode: Text.WordWrap
        }
    }

    Image {
        id: image
        y: Theme.paddingSmall
        sourceRef: modelData.box.images
        width: Theme.itemSizeSmall
        height: Theme.itemSizeSmall
        fillMode: Image.PreserveAspectCrop
        busyIndicatorSize: BusyIndicatorSize.Small
        visible: hasImage
    }

    onClicked: {
        var linkRe = /<a href="([^\"]+)" type="([^\"]+)">([^<]+)<\/a>/
        var match = linkRe.exec(modelData.box.link)
        if (match !== null) {
            if (match[2] === "intern") {
                console.log("Clicked intern link: " + match[1])
                pageStack.push(
                    Qt.resolvedUrl("../pages/ContentPage.qml"),
                    { url: match[1] })
            } else {
                console.log("Clicked extern link: " + match[1])
                Qt.openUrlExternally(match[1])
            }
        } else {
            console.warn("Failed to detect link: " + modelData.box.link)
        }
    }
}
