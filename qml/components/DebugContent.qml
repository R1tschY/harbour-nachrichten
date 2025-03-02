import QtQuick 2.0

Item {
    width: page.width
    height: delegate.height

    Image {
        source: dbgImage(modelData.type)
        opacity: 0.5
        anchors.right: parent.right
    }

    Loader {
        id: delegate
        source: contentView.contentItemSource(modelData.type)
    }

    function dbgImage(type) {
        var result = {
            "text": "image://theme/icon-m-font-size",
            "headline": "image://theme/icon-m-about",
            "quotation": "image://theme/icon-m-message",

            "box": "image://theme/icon-m-link",

            "audio": "image://theme/icon-m-mic",
            "video": "image://theme/icon-m-media",
            "image_gallery": "image://theme/icon-m-image",

            "socialmedia": "../components/ContentTwitter.qml",

            //"related": "../components/ContentIgnore.qml",
            //"list": "../components/ContentIgnore.qml",
        }[type]
        if (result === undefined) {
            return "image://theme/icon-m-other"
        }
        return result
    }
}
