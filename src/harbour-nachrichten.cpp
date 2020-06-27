#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <QtQml>

#include <sailfishapp.h>

#include "jsonlistmodel.h"
#include "settings.h"

int main(int argc, char* argv[])
{
    // SailfishApp::main() will display "qml/harbour-nachrichten.qml", if you need more
    // control over initialization, you can use:
    //
    //   - SailfishApp::application(int, char *[]) to get the QGuiApplication *
    //   - SailfishApp::createView() to get a new QQuickView * instance
    //   - SailfishApp::pathTo(QString) to get a QUrl to a resource file
    //   - SailfishApp::pathToMainQml() to get a QUrl to the main QML file
    //
    // To display the view, call "show()" (will show fullscreen on device).

    qmlRegisterType<JsonListModel>(
        "Nachrichten.Models", 1, 0, "JsonListModel");
    qmlRegisterType<Cute::Settings>(
        "Cute.Storage", 0, 1, "Settings");

    return SailfishApp::main(argc, argv);
}
