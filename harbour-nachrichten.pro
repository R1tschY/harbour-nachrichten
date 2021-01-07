# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-nachrichten

QT += multimedia

CONFIG += sailfishapp
CONFIG += link_pkgconfig

PKGCONFIG += sailfishsecrets sailfishapp

SOURCES += src/harbour-nachrichten.cpp \
    src/jslistmodel.cpp \
    src/jsonlistmodel.cpp \
    src/settings.cpp

HEADERS +=  \
    src/jslistmodel.h \
    src/jsonlistmodel.h \
    src/settings.h

DISTFILES += qml/harbour-nachrichten.qml \
    qml/components/*.qml \
    qml/cover/*.qml \
    qml/pages/*.qml \
    rpm/harbour-determinant.changes.in \
    rpm/harbour-determinant.changes.run.in \
    rpm/harbour-determinant.spec \
    rpm/harbour-determinant.yaml \
    translations/*.ts \
    harbour-nachrichten.desktop

DEFINES += \
    QT_DEPRECATED_WARNINGS \
    QT_DISABLE_DEPRECATED_BEFORE=0x050600
# DEFINES +=QT_USE_QSTRINGBUILDER # Problems with libquotient
CONFIG(release, debug|release):DEFINES += QT_NO_DEBUG_OUTPUT QT_NO_DEBUG

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-nachrichten-de.ts
