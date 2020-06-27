import QtQuick 2.0
import "../js/request.js" as Request

QtObject {
    id: root

    property bool busy: false
    property string url: null

    signal finished(var response)
    signal error(var error)

    function reload() {
        if (busy) return;

        busy = true
        Request.get(url).then(root._onSuccess, root._onError)
    }

    function _onSuccess(response) {
        busy = false
        root.finished(response)
    }

    function _onError(error) {
        busy = false
        root.error(error)
    }
}
