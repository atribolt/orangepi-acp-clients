

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    width: 200
    height: col1.height
    color: Constants.backDark

    property alias host: hostSetter.text
    property alias port: portSetter.text

    property string title: qsTr("OrangePC")

    signal hostPortChanged(string host, int port)

    Column {
        id: col1
        width: parent.width
        spacing: 3

        Label {
          id: lbTitle
            color: Constants.fontLight
            text: root.title
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        RowLayout {
            id: row1
            width: parent.width
            spacing: 10

            Label {
                color: Constants.fontLight
                text: qsTr("Хост:")
            }
            CustomTextInput {
                Layout.fillWidth: true
                id: hostSetter
                text: "localhost"
                selectByMouse: true
            }
        }
        RowLayout {
            id: row2
            width: parent.width
            spacing: 10

            Label {
                color: Constants.fontLight
                text: qsTr("Порт:")
            }
            CustomTextInput {
                Layout.fillWidth: true
                id: portSetter
                text: "9000"
                selectByMouse: true
                maximumLength: 5
                validator: IntValidator {
                    bottom: 1
                    top: 65000
                }
            }
        }
        CustomButton {
            id: btnUpdate
            width: parent.width
            text: qsTr("Применить")
            height: 31
            enabled: portSetter.acceptableInput && hostSetter.text.length > 0

            Connections {
                target: btnUpdate
                function onClicked() {
                    root.hostPortChanged(root.host, root.port)
                }
            }
        }
    }
}
