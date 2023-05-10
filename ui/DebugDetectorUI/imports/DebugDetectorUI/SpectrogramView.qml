import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

ChartView {
  id: spectrogram
  width: 400
  height: 400
  titleColor: Constants.fontLight
  backgroundColor: Constants.backDark
  legend.labelColor: Constants.fontLight

  property int frequency: 250000
  property double factor: 1

  ValueAxis {
    id: axisY
    min: -100
    max: 300
    color: Constants.fontLight
    tickCount: 10
    titleText: qsTr("dBm")
    gridVisible: false
    labelsColor: Constants.fontLight
  }

  ValueAxis {
    id: axisX
    min: 0
    max: spectrogram.frequency
    color: Constants.fontLight
    titleText: qsTr("Frequency")
    gridVisible: false
    labelsColor: Constants.fontLight
  }

  LineSeries {
    color: Constants.lineColor
    pointsVisible: false
    pointLabelsVisible: false
    name: "s"

    axisX: axisX
    axisY: axisY

    XYPoint {
      x: 0
      y: 10
    }
    XYPoint {
      x: 5000
      y: 10
    }
  }

  Rectangle {
    id: selectArea
    x: 0; y: 0; width: 100; height: 100
    color: "#000000ff"
    border.color: Constants.borderDarkDefault
    border.width: 1
    visible: false
  }

  MouseArea {
    id: spectrControl
    anchors.fill: parent
    acceptedButtons: Qt.AllButtons

    property point startSelect: "0,0"

    Connections {
      target: spectrControl
      function onPressed(event) {
        spectrControl.startSelect =
          Qt.point(event.x, event.y)

        if (event.buttons & Qt.LeftButton) {
          selectArea.visible = true
        }
      }

      function onPositionChanged(event) {
        if (event.buttons & Qt.LeftButton) {
          let x0 = spectrControl.startSelect.x
          let y0 = spectrControl.startSelect.y
          let x1 = event.x
          let y1 = event.y

          let x = Math.min(x0, x1)
          let y = Math.min(y0, y1)
          let w = Math.max(x0, x1) - x
          let h = Math.max(y0, y1) - y

          selectArea.x = x
          selectArea.y = y
          selectArea.width = w
          selectArea.height = h
        }
      }

      function onReleased(event) {
        if (event.button & Qt.LeftButton) {
          spectrogram.zoomIn(
            Qt.rect(selectArea.x,
                    selectArea.y,
                    selectArea.width,
                    selectArea.height))

          selectArea.visible = false
        }
        else if (event.button & Qt.RightButton) {
          spectrogram.zoomOut()
        }
      }

      function onWheel(event) {
        if (event.modifiers & Qt.ControlModifier) {
          spectrogram.factor += 0.0001 * event.angleDelta.y
          spectrogram.zoom(spectrogram.factor)
        }
        else if (event.modifiers & Qt.ShiftModifier) {
          spectrogram.scrollRight(event.angleDelta.y)
        }
        else {
          spectrogram.scrollDown(event.angleDelta.y)
        }
      }
    }
  }
}
