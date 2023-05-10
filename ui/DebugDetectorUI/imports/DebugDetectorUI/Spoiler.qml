import QtQuick 2.15
import QtQuick.Controls 2.15
import DebugDetectorUI 1.0

Rectangle {
  id: root
  width: 300
  height: col1.height + border.width * 4
  color: Constants.backDark
  border.width: 2
  implicitWidth: width - border.width * 4

  property alias contentItem: col1.contentItem

  Column {
    id: col1
    width: parent.implicitWidth
    anchors.centerIn: parent

    property var contentItem: root.contentItem

    CustomButton {
      id: btnSpoiler
      width: parent.width
      anchors.horizontalCenter: parent.horizontalCenter
      checkable: true
    }
  }
  states: [
      State {
      name: "inSpoiler"
      when: btnSpoiler.checked

      PropertyChanges {
        target: root.contentItem
        visible: false
      }

      PropertyChanges {
        target: btnSpoiler
        text: "Развернуть"
      }
    },
    State {
      name: "fullView"
      when: !btnSpoiler.checked
      PropertyChanges {
        target: root.contentItem
        visible: true
      }

      PropertyChanges {
        target: btnSpoiler
        text: "Свернуть"
      }
    }
  ]

}
