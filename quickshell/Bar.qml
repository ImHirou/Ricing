import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    id: root

    property color primaryColor: Qt.rgba(0.15, 0.15, 0.15, 0.9)
    property color borderColor: Qt.rgba(0.05, 0.05, 0.05, 0.92)

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            surfaceFormat.opaque: false

            anchors {
                top: true
                left: true
                bottom: true
            }

            color: Qt.rgba(0, 0, 0, 0)

            implicitWidth: 12

            Rectangle {
                anchors.fill: parent
                border {
                    width: 3
                    color: borderColor
                }
                color: primaryColor
            } 

            ClockWidget {
                anchors.centerIn: parent
            }
        }

    }

    Variants {
        model: Quickshell.screens
    
        PanelWindow {
            required property var modelData
            screen: modelData

            surfaceFormat.opaque: false
            color: Qt.rgba(0, 0, 0, 0)

            anchors {
                bottom: true
                left: true
                right: true
            }

            Rectangle {
                anchors.fill: parent
                border {
                    width: 3
                    color: borderColor
                }
                color: primaryColor
            }

            implicitHeight: 12
        }
    }
}
