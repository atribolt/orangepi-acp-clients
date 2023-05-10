import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

ChartView {
  id: spline
  objectName: "signalView"
  width: 400
  height: 400
  titleColor: "#e6e6ff"
  backgroundColor: Constants.backDark
  legend.labelColor: Constants.fontLight

  property int xMaxCount: 10
  property int riseThreshold: 3

  ValueAxis {
    id: axisY
    min: -100
    max: 300
    color: Constants.fontLight
    gridVisible: false
    labelsColor: Constants.fontLight
  }

  ValueAxis {
    id: axisX
    min: 0
    max: 250000
    color: Constants.fontLight
    gridVisible: false
    labelsColor: Constants.fontLight
  }

  LineSeries {
    color: Constants.fontIncorrect
    pointsVisible: false
    pointLabelsVisible: false
    name: "Пиковый порог"

    axisX: axisX
    axisY: axisY

    XYPoint {
      x: axisX.min
      y: spline.riseThreshold
    }

    XYPoint {
      x: axisX.max
      y: spline.riseThreshold
    }
  }

  SplineSeries {
    color: Constants.lineColor
    pointsVisible: false
    pointLabelsVisible: false
    name: "Спектр"

    axisX: axisX
    axisY: axisY
  }
}
