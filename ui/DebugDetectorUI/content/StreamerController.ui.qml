

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 2.15
import QtQuick.Controls 2.15
import DebugDetectorUI 1.0

Rectangle {
    id: streamerController
    width: 300
    height: items.height + border.width * 4
    color: Constants.backDark
    border.width: 2
    implicitWidth: width - border.width * 4

    property alias isEnabled: streamerChangeState.checked
    property alias title: lbTitle.text

    property alias storageHost: signalStorage.host
    property alias storagePort: signalStorage.port

    signal storageChanged(string host, int port)

    Column {
        id: items
        width: parent.implicitWidth
        anchors.centerIn: parent
        spacing: 5

        Label {
            id: lbTitle
            text: qsTr("Стриминг сигнала")
            font.bold: true
            color: Constants.fontLight
            font.pixelSize: 15
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Row {
            width: parent.width
            spacing: 10

            Label {
                text: qsTr("Состояние:")
                color: Constants.fontLight
                anchors.verticalCenter: parent.verticalCenter
            }
            Switch {
                id: streamerChangeState
                anchors.verticalCenter: parent.verticalCenter
                scale: 0.5
            }
        }

        HostPort {
            id: signalStorage
            title: qsTr("Приемник сигнала")
            width: parent.width

            Connections {
                target: signalStorage
                function onHostPortChanged(host, port) {
                    streamerController.storageChanged(host, port)
                }
            }
        }
    }
}
