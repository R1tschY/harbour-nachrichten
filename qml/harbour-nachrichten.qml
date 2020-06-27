import QtQuick 2.0
import Sailfish.Silica 1.0
import Cute.Storage 0.1
import "pages"

ApplicationWindow
{
    Settings {
        id: settings
    }

    initialPage: Component { FirstPage { } }

    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
}
