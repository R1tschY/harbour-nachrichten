import QtQuick 2.0
import Sailfish.Silica 1.0

Column {
    width: parent.width

    Component {
        id: delegate

        BackgroundItem {
            height: Math.max(column.height, teaserImage.height + Theme.paddingSmall + dateLabel.height)

            Column {
                id: column
                x: Theme.horizontalPageMargin / 2 + Theme.itemSizeSmall

                Label {
                    text: (modelData.topline) ? modelData.topline : ""
                    width: page.width - Theme.horizontalPageMargin - Theme.itemSizeSmall
                    truncationMode: TruncationMode.Fade
                    font.pixelSize: Theme.fontSizeSmall * 0.9
                    color: Theme.secondaryColor
                    visible: !!modelData.topline
                }

                Label {
                    text: modelData.title
                    width: page.width - Theme.horizontalPageMargin - Theme.itemSizeSmall
                    truncationMode: TruncationMode.Fade
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.WordWrap
                }
            }

            NImage {
                id: teaserImage
                y: Theme.paddingSmall
                spec: modelData.teaserImage
                size: "1x1-144"
                width: 144
                height: 144
                fillMode: Image.PreserveAspectCrop
                busyIndicatorSize: BusyIndicatorSize.Small
            }

            Label {
                id: dateLabel
                text: new Date(modelData.date).toLocaleString(Qt.locale("de_DE"), Locale.ShortFormat).replace(" ", "\n")
                textFormat: Text.PlainText
                font.pixelSize: Theme.fontSizeExtraSmall
                horizontalAlignment: Text.AlignRight
                anchors {
                    right: teaserImage.right
                    top: teaserImage.bottom
                    topMargin: Theme.paddingSmall
                }
            }

            onClicked: {
                pageStack.push(
                    Qt.resolvedUrl("../pages/ContentPage.qml"),
                    { item: modelData })
            }
        }
    }

    SectionHeader {
        text: "Mehr zum Thema"
    }

    InlineListView {
        width: page.width

        delegate: delegate

        spacing: Theme.paddingMedium

        model: modelData.related
    }
}
