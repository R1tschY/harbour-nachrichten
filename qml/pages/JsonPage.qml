import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: page

    property var content

    SilicaFlickable {
        id: flickable
        contentHeight: jsonText.height
        contentWidth: jsonText.width
        flickableDirection: Flickable.HorizontalAndVerticalFlick

        anchors.fill: parent

        Text {
            id: jsonText

            font {
                pixelSize: Theme.fontSizeExtraSmall
                family: "monospace"
            }

            text: typeof content === "string" ? content : JSON.stringify(content, null, 2)
            textFormat: Text.PlainText
            color: Theme.highlightColor
        }
    }
}
