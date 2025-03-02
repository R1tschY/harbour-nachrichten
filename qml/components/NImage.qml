import QtQuick 2.0
import Sailfish.Silica 1.0

Image {
    id: image

    property var spec
    property string size

    property alias busyIndicatorSize: indicator.size

    source: chooseImage(size, spec)
    asynchronous: true

    // TODO: use image.progress
    BusyIndicator {
        id: indicator
        size: BusyIndicatorSize.Small
        anchors.centerIn: image
        running: image.status === Image.Loading
    }

    function chooseImage(size, spec) {
        if (!spec) {
            return ""
        }

        var variants = spec.imageVariants
        //console.log("I", width, height, "->", size)

        if (!size) {
            console.warn("Missing size:", JSON.stringify(spec))
            return ""
        }

        if (!variants) {
            console.warn("Missing image variants:", JSON.stringify(spec))
            return ""
        }

        var prefered = variants[size]
        if (prefered) {
            return prefered
        }

        var keys = Object.keys(variants)

        console.log("Size", size, "not provided:", keys)

        var fallback;
        if (size.indexOf("1x1-") === 0) {
            for (var i = 0; i < keys.length; i++) {
                if (keys[i].indexOf("1x1-") === 0) {
                    fallback = keys[i];
                }
            }
        }

        if (size.indexOf("16x9-") === 0) {
            for (var i = 0; i < keys.length; i++) {
                if (keys[i].indexOf("16x9-") === 0) {
                    fallback = keys[i];
                }
            }
        }

        if (!fallback) {
            console.log("No fallback found:", size, size.indexOf("16x9-"), keys)
            return ""
        }

        console.log("Size", size, "not provided:", keys, "using", fallback)

        return variants[fallback]
    }
}
