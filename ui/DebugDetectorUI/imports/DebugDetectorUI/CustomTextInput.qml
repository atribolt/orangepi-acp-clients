import QtQuick 2.15
import QtQuick.Controls 2.15

TextInput {
  id: root

  width: 200
  height: 31
  color: acceptableInput ? Constants.fontLight : Constants.fontIncorrect
  horizontalAlignment: Text.AlignHCenter
  verticalAlignment: Text.AlignVCenter
  selectionColor: "#bf00c6"
  selectedTextColor: Constants.fontLight
  font.hintingPreference: Font.PreferFullHinting
  selectByMouse: true
  padding: 5

  Rectangle {
    z: -2
    anchors.fill: parent
    border.color: Constants.borderDarkDefault
    border.width: 1
    radius: 5
    color: parent.enabled ? Constants.backDark : Constants.backDarkDisabled
  }
}
