import QtQuick 2.0
import Sailfish.Silica 1.0
import "."

SilicaListView {
    id: contentView

    property var item: ({})

//    property alias updateCheckUrl: item.updateCheckUrl
//    property alias details: item.details
//    property alias content: item.content
//    property alias detailsWeb: item.detailsweb
//    property alias shareUrl: item.shareURL

    function itemSource(type) {
        return app.dbg ? Qt.resolvedUrl("./DebugContent.qml") : contentItemSource(type)
    }

    function contentItemSource(type) {
        var result = {
            "text": "../components/ContentText.qml",
            "headline": "../components/ContentText.qml",
            "quotation": "../components/ContentQuotation.qml",

            "box": "../components/ContentBox.qml",

            "audio": "../components/ContentAudio.qml",
            "video": "../components/ContentVideo.qml",
            "image_gallery": "../components/ContentImageGallery.qml",

            "socialmedia": "../components/ContentTwitter.qml",

            "related": "../components/ContentRelated.qml",
            //"list": "../components/ContentIgnore.qml",
        }[type]
        if (result === undefined) {
            console.log("Unknown content type " + type)
            return "../components/ContentUnknown.qml"
        }
        return result
    }

    model: item.content
    anchors.fill: parent

    spacing: Theme.paddingLarge

    header: Column {
        width: page.width
        spacing: Theme.paddingMedium

        NImage {
            spec: item.teaserImage
            size: "16x9-" + page.width
            width: page.width
            height: page.width * 9 / 16
            fillMode: Image.PreserveAspectFit
            busyIndicatorSize: BusyIndicatorSize.Small
            visible: !!source
        }

        TextBlock {
            text: item.topline ? item.topline : ""
            textFormat: Text.PlainText
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.secondaryColor
            visible: !!text
        }

        TextBlock {
            text: item.title ? item.title : ""
            textFormat: Text.PlainText
            font.pixelSize: Theme.fontSizeMedium
            font.bold: true
            visible: !!text
        }

        TextBlock {
            text: "Stand: " + new Date(item.date).toLocaleString(Qt.locale("de_DE"), Locale.ShortFormat)
            textFormat: Text.PlainText
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.secondaryColor
        }

        Item {
            width: parent.width
            height: Theme.paddingLarge
        }
    }

    delegate: Loader {
        id: delegate
        source: itemSource(modelData.type)
    }

    VerticalScrollDecorator { flickable: contentView }
}
