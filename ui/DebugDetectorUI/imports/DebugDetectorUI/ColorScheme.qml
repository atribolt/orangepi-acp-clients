import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
  id: root
  width: 500
  height: 500

  RowLayout {
    anchors.fill: parent
    spacing: 0

    Column {
      Layout.preferredWidth: 1
      Layout.fillWidth: true
      Layout.fillHeight: true

      Row {
        width: parent.width
        height: parent.height / 2

        Rectangle {
          anchors.fill: parent
          color: Constants.colorFront
        }
      }
      Row {
        width: parent.width
        height: parent.height / 2

        Rectangle {
          anchors.fill: parent
          color: Constants.colorFrontLight
        }
      }
    }

    Column {
      Layout.preferredWidth: 1
      Layout.fillWidth: true
      Layout.fillHeight: true

      Rectangle {
        anchors.fill: parent
        color: Constants.colorBase
      }
    }

    Column {
      Layout.preferredWidth: 1
      Layout.fillWidth: true
      Layout.fillHeight: true
      Row {
        width: parent.width
        height: parent.height / 2

        Rectangle {
          anchors.fill: parent
          color: Constants.colorBackLight
        }
      }
      Row {
        width: parent.width
        height: parent.height / 2

        Rectangle {
          anchors.fill: parent
          color: Constants.colorBack
        }
      }
    }
  }
}
