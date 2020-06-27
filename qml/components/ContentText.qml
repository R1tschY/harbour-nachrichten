import QtQuick 2.0
import Sailfish.Silica 1.0

TextBlock {
    text: modelData.value
    font.pixelSize: Theme.fontSizeSmall

    onLinkActivated: {
        console.log("Clicked: " + link)
    }
}
