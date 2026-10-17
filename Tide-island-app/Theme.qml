pragma Singleton
import QtQuick

QtObject {
    readonly property bool darkMode: backend.colorScheme === "dark"

    readonly property color totalBgColor: darkMode ? "#1e1e20" : "#f5f5f7"
    readonly property color componentBgColor: darkMode ? "#28282b" : "#eaeaee"
    readonly property color cardBgColor: darkMode ? "#2c2c2f" : "#ffffff"
    readonly property color cardBorderColor: darkMode ? "#3d3d41" : "#dedee3"
    readonly property color tableHeaderBgColor: componentBgColor
    readonly property color tableFooterBgColor: totalBgColor
    readonly property color sidebarColor: darkMode ? "#252527" : "#ebebef"
    readonly property color sidebarSelectionColor: darkMode ? "#3a3a3e" : "#d7d7dd"

    readonly property color inputBgColor: darkMode ? "#232326" : "#f9f9fb"
    readonly property color inputHoverBgColor: darkMode ? "#303034" : "#ffffff"
    readonly property color inputBorderColor: darkMode ? "#48484d" : "#d2d2d7"
    readonly property color inputHoverBorderColor: darkMode ? "#68686e" : "#aaaab1"
    readonly property color focusBorderColor: accentColor
    readonly property color focusRingColor: darkMode ? "#593382ff" : "#402079ef"

    readonly property color textColor: darkMode ? "#f5f5f7" : "#1d1d1f"
    readonly property color secondaryTextColor: darkMode ? "#b7b7bf" : "#606068"
    readonly property color subtleTextColor: darkMode ? "#a1a1aa" : "#6e6e77"
    readonly property color splitLineColor: darkMode ? "#3b3b40" : "#dedee3"

    readonly property color buttonColor: accentColor
    readonly property color buttonHoverColor: darkMode ? "#409cff" : "#0062d6"
    readonly property color buttonPressedColor: "#0055bd"
    readonly property color buttonTextColor: "#ffffff"
    readonly property color mutedButtonColor: darkMode ? "#414145" : "#ffffff"
    readonly property color mutedButtonHoverColor: darkMode ? "#4c4c52" : "#f0f0f4"
    readonly property color mutedButtonTextColor: textColor
    readonly property color controlHoverColor: darkMode ? "#424247" : "#e2e2e8"
    readonly property color controlPressedColor: darkMode ? "#4d4d53" : "#d5d5dd"

    readonly property color accentColor: darkMode ? "#0a84ff" : "#007aff"
    readonly property color accentDarkColor: "#0062d6"
    readonly property color accentSoftColor: darkMode ? "#233b58" : "#e4efff"
    readonly property color selectedColor: accentColor
    readonly property color overlayColor: "#66000000"

    readonly property color errorBgColor: darkMode ? "#3c0e0e" : "#fff1ed"
    readonly property color errorBorderColor: darkMode ? "#641919" : "#f2b8a2"
    readonly property color errorTextColor: darkMode ? "#f4abab" : "#8f2f16"

    readonly property int animationDuration: 160

    readonly property string textFontFamily: textFont.status === FontLoader.Ready ? textFont.name : "Inter"
    readonly property string titleFontFamily: textFontFamily
    readonly property string interFontFamily: textFontFamily
    readonly property string loraFontFamily: titleFontFamily
    readonly property string fontFamily: textFontFamily

    readonly property FontLoader textFont: FontLoader {
        source: "qrc:/RES/InterVariable.ttf"
    }

}
