import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15
import QtQuick.Layouts 1.15

import DebugDetectorUI 1.0

Rectangle {
  id: root

  width: 1000
  height: 400

  color: Constants.backDark

  RowLayout {
    anchors.fill: parent

    ScrollView {
      id: scrollView
      Layout.fillHeight: true

      Column {
        width: parent.width
        spacing: 5

        OrangeController {
          id: orangeController
          objectName: 'orangeController'
        }
        DetectorController {
          id: detectorController
          objectName: 'detectorController'
        }
      }
    }

    SpectrogramView {
      objectName: 'spectrogram'
      Layout.fillWidth: true
      Layout.fillHeight: true
    }
  }
}
