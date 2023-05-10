import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import DebugDetectorUI 1.0


Rectangle {
  id: root

  width: 300
  height: col1.height + border.width * 4
  color: Constants.backDark
  border.width: 2
  implicitWidth: width - border.width * 4

  property bool hostAvailable: false
  property string softwareVersion: "unknown"

  signal loadDetectorInfo
  signal hostPortChanged(string host, int port)

  Column {
    id: col1
    width: parent.implicitWidth
    anchors.centerIn: parent
    spacing: 10

    HostPort {
      id: detectorHost
      width: parent.width
      title: qsTr("Датчик")

      Connections {
        target: detectorHost
        function onHostPortChanged(host, port) {
          root.hostPortChanged(host, port)
        }
      }
    }

    Label {
      id: labelHostAvailable
      anchors.horizontalCenter: parent.horizontalCenter
      text: qsTr("Хост не доступен")
      font.bold: true
      color: Constants.fontLight
    }

    Label {
      id: labelSoftwareAvailable
      anchors.horizontalCenter: parent.horizontalCenter
      text: qsTr("ПО не активно")
      font.bold: true
      color: Constants.fontLight
    }

    CustomButton {
      id: btnLoadDetectorInfo
      text: qsTr("загрузить информацию о датчике")
      font.letterSpacing: 0.1
      font.wordSpacing: 0
      font.pointSize: 10
      width:parent.width
      anchors.horizontalCenter: parent.horizontalCenter

      Connections {
        target: btnLoadDetectorInfo
        function onClicked() {
          root.loadDetectorInfo()
        }
      }
    }
  }

  StateGroup {
    id: aboutHost
    states: [
      State {
        name: "hostNotAvailable"
        when: !root.hostAvailable

        PropertyChanges {
          target: labelHostAvailable
          color: Constants.fontNegative
          text: qsTr("Хост недоступен")
        }
      },
      State {
        name: "hostAvailable"
        when: root.hostAvailable
        PropertyChanges {
          target: labelHostAvailable
          color: Constants.fontPositive
          text: qsTr("Хост определен")
        }
      }
    ]

  }

  StateGroup {
    id: aboutSoftware
    states: [
      State {
        name: "softwareAvailable"
        when: root.softwareVersion != "unknown"
        PropertyChanges {
          target: labelSoftwareAvailable
          color: Constants.fontPositive
          text: qsTr("ПО: ") + root.softwareVersion
        }

        PropertyChanges {
          target: btnLoadDetectorInfo
          enabled: true
        }
      },
      State {
        name: "softwareNotAvailable"
        when: root.softwareVersion == "unknown"

        PropertyChanges {
          target: labelSoftwareAvailable
          color: Constants.fontNegative
          text: qsTr("ПО недоступно")
        }
        PropertyChanges {
          target: btnLoadDetectorInfo
          enabled: false
        }
      }
    ]
  }
}
