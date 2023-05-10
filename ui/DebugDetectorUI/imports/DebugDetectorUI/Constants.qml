pragma Singleton
import QtQuick 2.15

QtObject {
    readonly property int debugWindowWidth: 1500
    readonly property int debugWindowHeight: 700

    readonly property int connectionWindowWidth: 300
    readonly property int connectionWindowHeight: 600

    readonly property string fontDark: "#07522A"
    readonly property string fontLight: "#EAC798"
    readonly property string fontPositive: "#1C8C50"
    readonly property string fontNegative: "#C68328"
    readonly property string fontIncorrect: "#ff0000"
    readonly property string backDark: "#082E4B"
    readonly property string backDarkDisabled: "#2B455A"
    readonly property string borderDarkDefault: "#EAB36A"
    readonly property string borderDarkDisabled: "#ff0000" //#2B455A"
    readonly property string btnBackDarkDefault: "#2B455A" // "#776FD3"
    readonly property string btnBackDarkPressed: "#0F0A51"
    readonly property string btnBackDarkHower: "#9894D3"
    readonly property string btnBackDarkDisabled: "#2B455A"
    readonly property string lineColor: "#8AD4AC"

    property string relativeFontDirectory: "fonts"

    /* Edit this comment to add your custom font */
    readonly property font font: Qt.font({
      family: Qt.application.font.family,
      pixelSize: Qt.application.font.pixelSize
    })
    readonly property font largeFont: Qt.font({
      family: Qt.application.font.family,
      pixelSize: Qt.application.font.pixelSize * 1.6
    })

    property DirectoryFontLoader directoryFontLoader: DirectoryFontLoader {
        id: directoryFontLoader
    }
}
