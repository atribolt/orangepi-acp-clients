

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import DebugDetectorUI 1.0

Rectangle {
    id: gpsController
    width: 300
    height: col1.height + border.width * 4
    color: Constants.backDark
    border.width: 2
    implicitWidth: width - border.width * 4

    property double longitude: 0.00
    property double latitude: 0.00
    property double altitude: 0.00

    property alias title: lbTitle.text

    Column {
        id: col1
        width: parent.implicitWidth
        anchors.centerIn: parent
        spacing: 3

        Label {
            id: lbTitle
            text: qsTr("GPS")
            font.bold: true
            font.pixelSize: 15
            color: Constants.fontLight
            anchors.horizontalCenter: parent.horizontalCenter
        }

        RowLayout {
            width: parent.width
            spacing: 10
            Label {
                Layout.fillWidth: true
                Layout.preferredWidth: 0.5
                text: qsTr("Широта:")
                color: Constants.fontLight
            }
            Label {
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                text: gpsController.latitude
                color: Constants.fontLight
            }
        }
        RowLayout {
            width: parent.width
            spacing: 10
            Label {
                Layout.fillWidth: true
                Layout.preferredWidth: 0.5
                text: qsTr("Долгота:")
                color: Constants.fontLight
            }
            Label {
                id: longitude
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                color: Constants.fontLight
                text: gpsController.longitude
            }
        }
        RowLayout {
            width: parent.width
            spacing: 10
            Label {
                Layout.fillWidth: true
                Layout.preferredWidth: 0.5
                color: Constants.fontLight
                text: qsTr("Высота:")
            }
            Label {
                Layout.fillWidth: true
                color: Constants.fontLight
                text: gpsController.altitude
                Layout.preferredWidth: 1
            }
        }
        Row {
            width: parent.width
            spacing: 10
            CustomTextInput {
                width: parent.width
                text: gpsController.latitude.toString(
                          ) + ", " + gpsController.longitude.toString()
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                selectByMouse: true
                readOnly: true
            }
        }
    }
}
