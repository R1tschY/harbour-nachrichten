import QtQuick 2.0
import Sailfish.Silica 1.0

TextBlock {
    text: JSON.stringify(modelData, null, 2)
    textFormat: Text.PlainText
    font.pixelSize: Theme.fontSizeExtraSmall
    font.family: "monospace"
    visible: app.dbg
}
