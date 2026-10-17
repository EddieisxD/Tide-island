import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import TideIsland 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 1040
    height: 720
    minimumWidth: 880
    minimumHeight: 600
    title: "Tide Island Settings"
    color: Theme.totalBgColor
    font.family: Theme.textFontFamily
    font.pixelSize: 13
    palette.window: Theme.totalBgColor
    palette.windowText: Theme.textColor
    palette.base: Theme.inputBgColor
    palette.alternateBase: Theme.componentBgColor
    palette.text: Theme.textColor
    palette.button: Theme.mutedButtonColor
    palette.buttonText: Theme.mutedButtonTextColor
    palette.highlight: Theme.selectedColor
    palette.highlightedText: Theme.buttonTextColor
    palette.placeholderText: Theme.subtleTextColor

    property int currentPage: 1

    Behavior on color {
        ColorAnimation { duration: Theme.animationDuration }
    }

    function pageForIndex(index) {
        return [generalPage, wallpaperPage, fontPage, shortcutPage, interactionPage][index - 1] || null
    }

    function selectPage(index) {
        const nextPage = pageForIndex(index)
        if (index === currentPage || !nextPage) return
        pageForIndex(currentPage).hidePage()
        currentPage = index
        nextPage.showPage()
    }

    Rectangle {
        id: sidebar
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: 220
        color: Theme.sidebarColor

        Behavior on color { ColorAnimation { duration: Theme.animationDuration } }

        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: 1
            color: Theme.splitLineColor
        }

        Button {
            x: 20
            y: 32
            width: parent.width - 40
            height: 48
            Accessible.name: "Tide Island on GitHub"
            onClicked: Qt.openUrlExternally("https://github.com/enhaoswen/Tide-island")
            background: Item {}
            contentItem: Row {
                spacing: 12
                Rectangle {
                    width: 40
                    height: 40
                    radius: 11
                    color: "#17171a"
                    border.width: 1
                    border.color: "#3a3a40"
                    Rectangle {
                        anchors.centerIn: parent
                        width: 26
                        height: 13
                        radius: 7
                        color: "#404047"
                        Rectangle {
                            width: 4
                            height: 4
                            radius: 2
                            color: "#0a84ff"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 4
                        }
                    }
                }
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 4
                    Text {
                        text: "Tide Island"
                        font.family: Theme.textFontFamily
                        font.pixelSize: 16
                        font.weight: Font.DemiBold
                        font.letterSpacing: -0.4
                        color: Theme.textColor
                    }
                    Text {
                        text: "Settings"
                        font.family: Theme.textFontFamily
                        font.pixelSize: 12
                        color: Theme.secondaryTextColor
                    }
                }
            }
        }

        Text {
            x: 24
            y: 112
            text: "PERSONALIZE"
            color: Theme.subtleTextColor
            font.family: Theme.textFontFamily
            font.pixelSize: 10
            font.weight: Font.DemiBold
            font.letterSpacing: 1
        }

        Column {
            x: 12
            y: 138
            width: parent.width - 24
            spacing: 4

            Repeater {
                model: [
                    { label: "General", color: "#8b8b93", path: "M9 3h6l1 3 3 1 2 5-2 5-3 1-1 3H9l-1-3-3-1-2-5 2-5 3-1z M16 12a4 4 0 1 0-8 0 4 4 0 0 0 8 0" },
                    { label: "Wallpaper", color: "#4d9bda", path: "M4 4h16v16H4z M4 16l5-5 4 4 3-3 4 4 M16 8h.01" },
                    { label: "Fonts", color: "#a279d7", path: "M4 20L10 4h4l6 16 M7 14h10" },
                    { label: "Shortcuts", color: "#e39043", path: "M9 9V5a2 2 0 1 0-2 2h10a2 2 0 1 0-2-2v14a2 2 0 1 0 2-2H7a2 2 0 1 0 2 2V9z" },
                    { label: "Interaction", color: "#55a58b", path: "M7 13V8a2 2 0 0 1 4 0v5-9a2 2 0 0 1 4 0v9-5a2 2 0 0 1 4 0v8c0 4-3 6-7 6-2 0-3-1-5-3l-3-4a2 2 0 0 1 3-2z" }
                ]

                delegate: Button {
                    id: navigationButton
                    required property var modelData
                    required property int index
                    readonly property bool selected: window.currentPage === index + 1
                    width: parent.width
                    height: 38
                    leftPadding: 10
                    rightPadding: 10
                    Accessible.name: modelData.label
                    Accessible.role: Accessible.PageTab
                    Accessible.selected: selected
                    onClicked: window.selectPage(index + 1)

                    background: Rectangle {
                        radius: 7
                        color: navigationButton.selected ? Theme.sidebarSelectionColor
                            : navigationButton.down ? Theme.controlPressedColor
                            : navigationButton.hovered ? Theme.controlHoverColor : "transparent"
                        border.width: navigationButton.visualFocus ? 2 : 0
                        border.color: Theme.focusBorderColor
                    }
                    contentItem: Row {
                        spacing: 10
                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 24
                            height: 24
                            radius: 6
                            color: navigationButton.modelData.color
                            Shape {
                                width: 24
                                height: 24
                                anchors.centerIn: parent
                                scale: 0.72
                                ShapePath {
                                    fillColor: "transparent"
                                    strokeColor: "white"
                                    strokeWidth: 1.8
                                    capStyle: ShapePath.RoundCap
                                    joinStyle: ShapePath.RoundJoin
                                    PathSvg { path: navigationButton.modelData.path }
                                }
                            }
                        }
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: navigationButton.modelData.label
                            font.family: Theme.textFontFamily
                            font.pixelSize: 13
                            font.weight: navigationButton.selected ? Font.DemiBold : Font.Normal
                            color: Theme.textColor
                        }
                    }
                }
            }
        }

        Column {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 20
            spacing: 10
            Text {
                text: "Appearance"
                color: Theme.secondaryTextColor
                font.family: Theme.textFontFamily
                font.pixelSize: 11
                font.weight: Font.Medium
            }
            Rectangle {
                width: parent.width
                height: 32
                radius: 8
                color: Theme.componentBgColor
                Row {
                    anchors.fill: parent
                    anchors.margins: 3
                    spacing: 2
                    Repeater {
                        model: ["Light", "Dark"]
                        delegate: Button {
                            id: appearanceButton
                            required property string modelData
                            readonly property bool selected: Theme.darkMode === (modelData === "Dark")
                            width: (parent.width - 2) / 2
                            height: parent.height
                            Accessible.name: modelData + " appearance"
                            onClicked: backend.setColorScheme(modelData.toLowerCase())
                            background: Rectangle {
                                radius: 5
                                color: appearanceButton.selected ? Theme.cardBgColor : "transparent"
                                border.width: appearanceButton.visualFocus ? 1 : 0
                                border.color: Theme.focusBorderColor
                            }
                            contentItem: Text {
                                text: appearanceButton.modelData
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                color: appearanceButton.selected ? Theme.textColor : Theme.secondaryTextColor
                                font.family: Theme.textFontFamily
                                font.pixelSize: 11
                                font.weight: appearanceButton.selected ? Font.DemiBold : Font.Normal
                            }
                        }
                    }
                }
            }
        }
    }

    Item {
        id: page
        anchors.left: sidebar.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        General { id: generalPage; anchors.fill: parent; visible: true; opacity: 1 }
        WallpaperSettings { id: wallpaperPage; anchors.fill: parent; visible: false; opacity: 0 }
        FontSettings { id: fontPage; anchors.fill: parent; visible: false; opacity: 0 }
        Shortcut { id: shortcutPage; anchors.fill: parent; visible: false; opacity: 0 }
        Interaction { id: interactionPage; anchors.fill: parent; visible: false; opacity: 0 }
    }

    Rectangle {
        id: configErrorBanner

        readonly property bool hasError: ConfigStore.errorString.length > 0

        z: 20
        visible: hasError
        opacity: hasError ? 1 : 0
        anchors.left: sidebar.right
        anchors.leftMargin: 24
        anchors.right: parent.right
        anchors.rightMargin: 24
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 18
        height: Math.max(48, errorText.implicitHeight + 20)
        radius: 8
        color: Theme.errorBgColor
        border.width: 1
        border.color: Theme.errorBorderColor

        Behavior on opacity { NumberAnimation { duration: Theme.animationDuration } }

        Text {
            id: errorText

            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.right: rewriteButton.left
            anchors.rightMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            text: "Config file error: " + ConfigStore.errorString
            color: Theme.errorTextColor
            wrapMode: Text.Wrap
            maximumLineCount: 2
            elide: Text.ElideRight
            font.family: Theme.textFontFamily
            font.pixelSize: 13
        }

        Rectangle {
            id: rewriteButton

            width: 112
            height: 32
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            radius: 6
            color: rewriteMouse.pressed ? Theme.buttonPressedColor
                                        : rewriteMouse.containsMouse ? Theme.buttonHoverColor
                                                                    : Theme.buttonColor

            Behavior on color { ColorAnimation { duration: Theme.animationDuration } }

            Text {
                anchors.centerIn: parent
                text: "Rewrite"
                color: Theme.buttonTextColor
                font.family: Theme.textFontFamily
                font.pixelSize: 13
            }

            MouseArea {
                id: rewriteMouse

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: ConfigStore.save()
            }
        }
    }
}
