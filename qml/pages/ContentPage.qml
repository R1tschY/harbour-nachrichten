import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: page

    property string url
    property alias item: content.item

    allowedOrientations: Orientation.All

    onUrlChanged: reload()

    function reload() {
        content.item = {
            details: content.item.details
        }
        newsRequest.reload()
    }

    Content {
        id: content

        PullDownMenu {
            MenuItem {
                text: "Aktuallisieren"
                onClicked: page.reload()
                visible: !!newsRequest.url
            }
            MenuItem {
                text: "In Browser öffnen"
                onClicked: Qt.openUrlExternally(item.detailsweb)
                visible: !!content.item.detailsweb
            }
            MenuItem {
                text: "Show JSON"
                onClicked: pageStack.push(Qt.resolvedUrl("./JsonPage.qml"), { content: content.item })
                visible: app.dbg
            }
        }
    }

    NewsRequest {
        id: newsRequest
        url: !!page.url ? page.url : (!!content.item.details ? content.item.details : "")

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
