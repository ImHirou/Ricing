import Quickshell
import QtQuick

PanelWindow {
    id: root
    property var modelData 
    screen: modelData

    property string bgSource
    property var pSources

    property int bgMaring: 32


    exclusionMode: ExclusionMode.Ignore
    aboveWindows: false
    color: "transparent"

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    Image {
        id: background
        anchors.fill: parent
        anchors.margins: -bgMaring
        fillMode: Image.PreserveAspectCrop
        source: bgSource
        smooth: false

        property real tX: 0
        property real tY: 0

        transform: Translate { id: trans; x: background.tX; y: background.tY }

        Behavior on tX { NumberAnimation { duration: 1340; easing.type: Easing.OutCubic } }
        Behavior on tY { NumberAnimation { duration: 1340; easing.type: Easing.OutCubic } }

    }

    Repeater {
        id: panorama
        model: pSources
        delegate: Image {
            source: modelData.source
            anchors.fill: background
            fillMode: Image.PreserveAspectCrop
            smooth: false

            property real centerX: modelData.x
            property real centerY: modelData.y

            property real tX: 0
            property real tY: 0

            transform: [
                Translate { id: trans; x: tX; y: tY },
                Scale { xScale: 1.13;  yScale: 1.13 ; origin.x: width/2; origin.y: height/2}
            ]

            Behavior on tX { NumberAnimation { duration: 1340; easing.type: Easing.OutCubic } }
            Behavior on tY { NumberAnimation { duration: 1340; easing.type: Easing.OutCubic } }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: (mouse) => {
            let centerX = root.screen.width/2;
            let centerY = root.screen.height/2;

            for (let i = 0; i < pSources.length; i++) {
                var img = panorama.itemAt(i); 
                if (!img) continue;

                let distX = mouse.x - img.centerX;
                let distY = mouse.y - img.centerY;

                img.tX = clamp(distX / 10, -bgMaring, bgMaring);
                img.tY = clamp(distY / 10, -bgMaring, bgMaring);
            }
            
            let dx = mouse.x - centerX;
            let dy = mouse.y - centerY;

            let bX = map(dx, -centerX, centerX, -bgMaring, bgMaring);
            let bY = map(dy, -centerY, centerY, -bgMaring, bgMaring);

            background.tX = bX;
            background.tY = bY;
        }
    }
    function map(value, inMin, inMax, outMin, outMax) {
        return outMin + ((value - inMin) * (outMax - outMin)) / (inMax - inMin);
    } 
    function clamp(value, outMin, outMax) {
        if (value < outMin) return outMin;
        else if (value > outMax) return outMax;
        else return value;
    }
}
