import QtQuick 2.15
import QtQuick.Controls 2.15

SpinBox {
  id: root
  width: 200
  height: 31

  background: Rectangle {
    anchors.fill: parent
    color: "#000000ff"
  }

  contentItem: CustomTextInput {
    id: inputValue
    text: root.value
    readOnly: !root.editable
    width: root.width - btnDec.width - btnInc.width
    height: root.height
    anchors.centerIn: parent
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    validator: IntValidator {
      bottom: root.from
      top: root.to
    }

    Connections {
      target: inputValue
      function onAccepted() {
        root.value = parseInt(inputValue.text)
      }
    }
  }
  down.indicator: CustomButton {
    z: 1
    id: btnDec
    radius: width / 2
    height: root.height - 15
    width: Math.min(height, 31)
    text: '<'
    anchors.right: inputValue.left
    anchors.verticalCenter: parent.verticalCenter

    Connections {
      target: btnDec
      function onPressed() {
        root.value -= root.stepSize
      }
    }
  }
  up.indicator: CustomButton {
    z: 1
    id: btnInc
    radius: width / 2
    height: root.height - 15
    width: Math.min(height, 31)
    text: '>'
    anchors.left: inputValue.right
    anchors.verticalCenter: parent.verticalCenter

    Connections {
      target: btnInc
      function onPressed() {
        root.value += root.stepSize
      }
    }
  }
}
