import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: page

    property var _regions: JSON.parse(settings.getItem("regions") || "[]")

    Component.onCompleted:  {
        console.log(_regions)
    }

    function isRegionActive(id) {
        return _regions.indexOf(id) !== -1
    }

    function enableRegion(id) {
        if (!isRegionActive(id)) {
            _regions.push(id)
            _regions.sort()
            settings.setItem("regions", JSON.stringify(_regions))
        }
    }

    function disableRegion(id) {
        if (isRegionActive(id)) {
            _regions.splice(_regions.indexOf(id), 1)
            settings.setItem("regions", JSON.stringify(_regions))
        }
    }

    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column

            PageHeader {
                title: "Einstellungen"
                width: page.width
            }

            SectionHeader {
                text: "Regionen"
                width: page.width
            }

            ColumnView {
                itemHeight: Theme.itemSizeMedium
                width: page.width

                model: [
                    {"id": 1, "name": "Baden-Württemberg", "source": "SWR" },
                    {"id": 2, "name": "Bayern", "source": "BR" },
                    {"id": 3, "name": "Berlin", "source": "RBB" },
                    {"id": 4, "name": "Brandenburg", "source": "RBB" },
                    {"id": 5, "name": "Bremen", "source": "Radio Bremen" },
                    {"id": 6, "name": "Hamburg", "source": "NDR" },
                    {"id": 7, "name": "Hessen", "source": "HR" },
                    {"id": 8, "name": "Mecklenburg-Vorpommern", "source": "NDR" },
                    {"id": 9, "name": "Niedersachsen", "source": "NDR" },
                    {"id": 10, "name": "Nordrhein-Westfalen", "source": "WDR" },
                    {"id": 11, "name": "Rheinland-Pfalz", "source": "SWR" },
                    {"id": 12, "name": "Saarland", "source": "SR" },
                    {"id": 13, "name": "Sachsen", "source": "MDR" },
                    {"id": 14, "name": "Sachsen-Anhalt", "source": "MDR" },
                    {"id": 15, "name": "Schleswig-Holstein", "source": "NDR" },
                    {"id": 16, "name": "Thüringen", "source": "MDR" }
                ]

                delegate: TextSwitch {
                    text: modelData.name
                    description: "von " + modelData.source
                    checked: isRegionActive(modelData.id)
                    onCheckedChanged: {
                        if (checked)
                            enableRegion(modelData.id)
                        else
                            disableRegion(modelData.id)
                    }
                }
            }
        }

        VerticalScrollDecorator { flickable: flickable }
    }
}
