import QtQuick 2.0
import Sailfish.Silica 1.0
import Nachrichten.Models 1.0
import "../components"

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    NewsRequest {
        id: newsRequest
        url: "https://www.tagesschau.de/api2/homepage/"

        onFinished: {
            var homepage = JSON.parse(response.data)
            newsModel.values = JSON.stringify(homepage.news)
            regionsModel.values = JSON.stringify(homepage.regional)
        }
    }

    Component.onCompleted: {
        newsRequest.reload()
    }

    JsonListModel {
        id: newsModel
        properties: ["title", "firstSentence", "teaserImage", "topline"]
    }

    JsonListModel {
        id: regionsModel
        properties: ["title", "firstSentence", "teaserImage", "topline"]
    }

    Component {
        id: delegate

        BackgroundItem {
            height: column.height

            Column {
                id: column
                x: Theme.horizontalPageMargin / 2 + Theme.itemSizeSmall

                Label {
                    text: (topline) ? topline : ""
                    width: page.width - Theme.horizontalPageMargin - Theme.itemSizeSmall
                    truncationMode: TruncationMode.Fade
                    font.pixelSize: Theme.fontSizeSmall * 0.9
                    color: Theme.secondaryColor
                    visible: !!topline
                }

                Label {
                    text: title
                    width: page.width - Theme.horizontalPageMargin - Theme.itemSizeSmall
                    truncationMode: TruncationMode.Fade
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.WordWrap
                }

                Label {
                    text: firstSentence || ""
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: Theme.secondaryColor
                    width: page.width - Theme.horizontalPageMargin - Theme.itemSizeSmall
                    wrapMode: Text.WordWrap
                }
            }

            Image {
                y: Theme.paddingSmall
                sourceRef: teaserImage
                width: Theme.itemSizeSmall
                height: Theme.itemSizeSmall
                fillMode: Image.PreserveAspectCrop
                busyIndicatorSize: BusyIndicatorSize.Small
            }

            onClicked: {
                pageStack.push(
                    Qt.resolvedUrl("ContentPage.qml"),
                    { item: modelData })
            }
        }
    }

    SlideshowView { }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: column.height

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Einstellungen")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }

            MenuItem {
                text: "Aktuallisieren"
                onClicked: newsRequest.reload()
            }
        }

        Column {
            id: column

            PageHeader {
                title: "Tagesschau"
                width: page.width
            }

            InlineListView {
                width: page.width

                delegate: delegate

                spacing: Theme.paddingMedium

                model: newsModel
            }

            SectionHeader {
                text: "Regional"
            }

            InlineListView {
                width: page.width

                delegate: delegate

                spacing: Theme.paddingMedium

                model: regionsModel
            }
        }

        VerticalScrollDecorator { flickable: flickable }
    }

    BusyIndicator {
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
        running: newsRequest.busy
    }
}
