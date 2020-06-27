import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: page

    property alias item: content.item

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    Content {
        id: content
    }
}
