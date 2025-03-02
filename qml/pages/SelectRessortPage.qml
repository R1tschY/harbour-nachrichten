import QtQuick 2.0
import Sailfish.Silica 1.0

import "../components"

Page {
    id: page

    allowedOrientations: Orientation.All

    Component {
        id: delegate

        BackgroundItem {
            height: Theme.itemSizeSmall

            Label {
                anchors {
                    baseline: parent.verticalCenter
                    baselineOffset: Theme.paddingSmall
                    left: parent.left
                    leftMargin: Theme.horizontalPageMargin
                }

                id: label
                text: name
            }

            onClicked: {
                pageStack.push(
                    Qt.resolvedUrl("NewsPage.qml"),
                    { ressort: ressort })
            }
        }
    }

    SilicaListView {
        id: flickable
        anchors.fill: parent

        header: PageHeader {
            title: "Wähle Ressort"
            width: page.width
        }

        delegate: delegate

        model: ListModel {
            ListElement {
                name: "Inland"
                ressort: "inland"
            }
            ListElement {
                name: "Ausland"
                ressort: "ausland"
            }
            ListElement {
                name: "Investigativ"
                ressort: "investigativ"
            }
            ListElement {
                name: "Wirtschaft"
                ressort: "wirtschaft"
            }
            ListElement {
                name: "Wissen"
                ressort: "wissen"
            }
            ListElement {
                name: "Sport"
                ressort: "sport"
            }
            ListElement {
                name: "Video"
                ressort: "video"
            }
        }

        VerticalScrollDecorator { flickable: flickable }
    }
}
