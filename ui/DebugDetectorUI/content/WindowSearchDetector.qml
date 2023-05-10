import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import DebugDetectorUI 1.0


Rectangle {
  id: wSearchDetector
  objectName: 'wSearchWindow'
//  title: "Поиск детектора"

  width: 1900
  height: 900
  color: Constants.backDark
  property bool hostAvailable: false
  property string softwareVersion: "unknown"

  signal startDebug
  signal loadDetectorInfo
  signal hostPortChanged(string host, int port)

  RowLayout {
    id: rl
    anchors.fill: parent

    Column {
      Layout.fillWidth: true
      Layout.preferredWidth: 1

      id: col1
      spacing: 10

      HostPort {
        id: detectorHost
        width: parent.width
        title: qsTr("Датчик")

        Connections {
          target: detectorHost
          function onHostPortChanged(host, port) {
            wSearchDetector.hostPortChanged(host, port)
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
            wSearchDetector.loadDetectorInfo()
          }
        }
      }

      CustomButton {
        id: btnStartDebug
        text: qsTr("Начать отладку")
        width: parent.width
        font.letterSpacing: 4
        font.pointSize: 10
        anchors.horizontalCenter: parent.horizontalCenter

  //      Connections {
  //        target: btnStartDebug
  //        function onClicked() {
  //          wSearchDetector.startDebug()
  //        }
  //      }
      }
    }

    DetectorController {
      id: detectorController
      Layout.fillWidth: true
      Layout.preferredWidth: 1
    }
  }


  StateGroup {
    id: aboutHost
    states: [
      State {
        name: "hostNotAvailable"
        when: !wSearchDetector.hostAvailable

        PropertyChanges {
          target: labelHostAvailable
          color: "#a21d16"
          text: qsTr("Хост недоступен")
        }
      },
      State {
        name: "hostAvailable"
        when: wSearchDetector.hostAvailable
        PropertyChanges {
          target: labelHostAvailable
          color: "#3bb009"
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
        when: wSearchDetector.softwareVersion != "unknown"

        PropertyChanges {
          target: labelSoftwareAvailable
          color: "#3bb009"
          text: qsTr("ПО: ") + wSearchDetector.softwareVersion
        }

        PropertyChanges {
          target: btnLoadDetectorInfo
          enabled: true
        }
      },
      State {
        name: "softwareNotAvailable"
        when: wSearchDetector.softwareVersion == "unknown"

        PropertyChanges {
          target: labelSoftwareAvailable
          color: "#a21d16"
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
