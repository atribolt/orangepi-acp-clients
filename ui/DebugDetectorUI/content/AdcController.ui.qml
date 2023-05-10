

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
    id: adcController
    width: 300
    height: items.height + border.width * 4
    border.width: 2

    implicitWidth: width - border.width * 4

    property int frequency: 0
    property bool usePPS: false
    property alias signalBiasValue: signalBiasSetter.value
    property alias title: lbTitle.text

    color: Constants.backDark

    Column {
        id: items
        width: parent.implicitWidth
        anchors.centerIn: parent
        spacing: 3

        Label {
            id: lbTitle
            text: qsTr("АЦП")
            font.bold: true
            color: Constants.fontLight
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Row {
            spacing: 10
            Label {
                color: Constants.fontLight
                text: qsTr("Частота:")
            }
            Label {
                color: Constants.fontLight
                text: adcController.frequency
            }
        }
        Row {
            spacing: 10
            Label {
                color: Constants.fontLight
                text: qsTr("Синхронизация по PPS:")
            }
            Label {
                color: Constants.fontLight
                text: adcController.usePPS
            }
        }
        RowLayout {
            width: parent.width
            spacing: 10
            Label {
                color: Constants.fontLight
                text: qsTr("Сдвиг сигнала:")
            }
            CustomSpinBox {
                id: signalBiasSetter
                objectName: 'signalBiasSetter'
                Layout.fillWidth: true
                editable: true
                stepSize: 1
                to: 600
                from: 400
            }
        }
    }
}
