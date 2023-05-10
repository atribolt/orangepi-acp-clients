

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
    id: peakDetectorController
    width: 300
    height: items.height + border.width * 4
    color: Constants.backDark
    border.width: 2
    implicitWidth: width - border.width * 4

    property int samplesLeft: 0
    property int avgAround: 0
    property alias samplesRight: samplesRightSetter.value
    property alias riseThreshold: riseThresholdSetter.value
    property alias isEnabled: peakChangeState.checked

    property alias storageHost: peakStorage.host
    property alias storagePort: peakStorage.port

    property alias title: lbTitle.text

    signal storageChanged(string host, int port)

    Column {
        id: items
        width: parent.implicitWidth
        anchors.centerIn: parent
        spacing: 10

        Label {
            id: lbTitle
            text: qsTr("Пиковый детектор")
            font.pixelSize: 15
            font.bold: true
            color: Constants.fontLight
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
                id: peakChangeState
                anchors.verticalCenter: parent.verticalCenter
                display: AbstractButton.IconOnly
                scale: 0.5
            }
        }
        RowLayout {
            width: parent.width
            spacing: 10

            Label {
                text: qsTr("Порог:")
                color: Constants.fontLight
            }
            CustomSpinBox {
                Layout.fillWidth: true
                id: riseThresholdSetter
                editable: true
                stepSize: 1
                to: 500
                from: -500
            }
        }
        Row {
            width: parent.width
            spacing: 10

            Label {
                color: Constants.fontLight
                text: qsTr("Сэмплов слева:")
            }
            Label {
                color: Constants.fontLight
                text: peakDetectorController.samplesLeft.toString()
            }
        }
        RowLayout {
            width: parent.width
            spacing: 10

            Label {
                color: Constants.fontLight
                text: qsTr("Сэмплов справа:")
            }
            CustomSpinBox {
                Layout.fillWidth: true
                id: samplesRightSetter
                editable: true
                stepSize: 1
                to: 50000
                from: 1000
            }
        }
        Row {
            width: parent.width
            spacing: 10

            Label {
                color: Constants.fontLight
                text: qsTr("Усреднение:")
            }
            Label {
                color: Constants.fontLight
                text: peakDetectorController.avgAround.toString()
            }
        }
        HostPort {
            id: peakStorage
            title: qsTr("Хранилище пиков")
            width: parent.width

            Connections {
                target: peakStorage
                function onHostPortChanged(host, port) {
                    peakDetectorController.storageChanged(host, port)
                }
            }
        }
    }
}
