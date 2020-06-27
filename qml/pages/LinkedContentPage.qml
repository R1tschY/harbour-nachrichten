import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: page

    property alias link: newsRequest.url

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    Content {
        id: content
        anchors.fill: page
        visible: !!link && !newsRequest.busy
    }

    NewsRequest {
        id: newsRequest

        onUrlChanged: {
            content.item = {}
            reload()
        }

        onFinished: {
            content.item = JSON.parse(response.data)
        }
    }

    BusyIndicator {
        size: BusyIndicatorSize.Large
        anchors.centerIn: page
        running: newsRequest.busy
    }
}
