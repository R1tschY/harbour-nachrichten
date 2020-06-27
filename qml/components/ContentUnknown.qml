import QtQuick 2.0
import Sailfish.Silica 1.0

TextBlock {
    text: "Unknown content: " + JSON.stringify(modelData)
    font.pixelSize: Theme.fontSizeSmall
}
