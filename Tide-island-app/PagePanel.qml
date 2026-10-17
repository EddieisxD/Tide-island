import QtQuick
import TideIsland 1.0

Rectangle {
    id: pagePanel
    color: "transparent"
    anchors.fill: parent

    default property alias content: pagePanel.data

    function showPage() {
        visible = true
        opacity = 1
    }

    function hidePage() {
        visible = false
        opacity = 0
    }
}
