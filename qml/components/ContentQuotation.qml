import QtQuick 2.0
import Sailfish.Silica 1.0

TextBlock {
    text: modelData.quotation.text
    font.pixelSize: Theme.fontSizeSmall
    color: Theme.secondaryColor
    padding: Theme.paddingLarge
}
