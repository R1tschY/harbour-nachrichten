import QtQuick 2.0
import Sailfish.Silica 1.0

Label {
    leftPadding: Theme.horizontalPageMargin
    rightPadding: Theme.horizontalPageMargin
    width: page.width
    wrapMode: Text.WordWrap
    linkColor: Theme.secondaryColor

    onLinkActivated: {
        if (link.indexOf("https://www.tagesschau.de/api2/") === 0) {
            pageStack.push(
                Qt.resolvedUrl("../pages/LinkedContentPage.qml"),
                { link: link })
        } else {
            console.log("Clicked extern link: " + link)
            Qt.openUrlExternally(link)
        }
    }
}
