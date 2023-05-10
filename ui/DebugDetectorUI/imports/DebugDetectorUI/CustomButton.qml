import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
  id: root
  width: 100
  height: 31
  text: "button"

  property alias radius: rect.radius

  background: Rectangle {
    id: rect
    anchors.fill: parent
    radius: 10
    color:
       root.pressed ? Constants.btnBackDarkPressed :
       (root.enabled && root.hovered) ? Constants.btnBackDarkHower : Constants.btnBackDarkDefault
    border.color: root.enabled ? Constants.borderDarkDefault : Constants.borderDarkDisabled
    border.width: 1
  }

  contentItem: Label {
    text: parent.text
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    color: Constants.fontLight
  }
}
