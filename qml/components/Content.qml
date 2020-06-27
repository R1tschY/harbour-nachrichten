import QtQuick 2.0
import Sailfish.Silica 1.0
import "."

SilicaListView {
    id: listView

    property var item: ({})

    function contentItemSource(type) {
        var result = {
            "text": "../components/ContentText.qml",
            "headline": "../components/ContentText.qml",
            "quotation": "../components/ContentQuotation.qml",

            "box": "../components/ContentBox.qml",

            "audio": "../components/ContentUnknown.qml",
            "video": "../components/ContentVideo.qml",
            "image_gallery": "../components/ContentImageGallery.qml",

            "socialmedia": "../components/ContentTwitter.qml",

            "related": "../components/ContentIgnore.qml",
            "list": "../components/ContentIgnore.qml",
        }[type]
        if (result === undefined) {
            console.log("Unknown content type " + type)
            return "../components/ContentUnknown.qml"
        }
        return result
    }

    model: item.content
    anchors.fill: parent

    spacing: Theme.paddingMedium

    header: Column {
        width: page.width

        Image {
            source: (item.images && item.images.length)
                ? item.images[0].videowebl.imageurl
                : ""
            width: page.width
            height: page.width * 9 / 16
            fillMode: Image.PreserveAspectFit
            busyIndicatorSize: BusyIndicatorSize.Small
            visible: !!source
        }

        TextBlock {
            text: (!!item.topline) ? item.topline : ""
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.secondaryColor
            visible: !!text
        }

        TextBlock {
            text: "<h1>" + item.title + "</h1>"
            font.pixelSize: Theme.fontSizeExtraSmall
        }
    }

    delegate: Loader {
        id: delegate
        source: contentItemSource(modelData.type)
    }

    VerticalScrollDecorator { flickable: listView }
}
