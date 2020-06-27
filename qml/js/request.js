.pragma library;

//.import "promise.js" as Promise;
Qt.include("promise.js")

function requestWithXMLHttpRequest(config) {
    var promise = new QPromise();
    var req = new XMLHttpRequest();

    req.onreadystatechange = function() {
        if (!req || req.readyState !== 4) {
            return
        }

        var resData = !config.responseType || config.responseType === 'text' ? req.responseText : req.response
        var response = {
            data: resData,
            status: req.status,
            statusText: req.statusText,
            headers: req.getAllResponseHeaders(),
            config: config,
            request: req
        }

        promise.resolve(response);

        req = null;
    }

    req.onabort = function() {
        if (!req) return;
        promise.reject("aborted")
        req = null;
    }

    req.onerror = function() {
        if (!req) return;
        promise.reject("network error");
        req = null;
    }

    req.ontimeout = function() {
        if (!req) return;
        promise.reject("timeout");
        req = null;
    }

    var requestData = config.data === undefined ? null : config.data
    req.open(config.method.toUpperCase(), config.url, true);
    req.send();
    return promise
}

function get(url, config) {
    console.log("GET " + url)
    var configObj = config || {}
    configObj.url = url
    configObj.method = "GET"
    return requestWithXMLHttpRequest(configObj)
}
