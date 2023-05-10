

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import DebugDetectorUI 1.0

Rectangle {
    id: detectorController

    width: 300
    height: items.height
    color: Constants.backDark

    Column {
        id: items
        width: parent.width
        anchors.centerIn: parent

        AdcController {
            id: adcController
            objectName: 'adcController'
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
        }
        PeakDetectorController {
            id: peakDetectorController
            objectName: 'peakDetectorController'
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
        }

        StreamerController {
            id: streamerController
            objectName: 'streamerController'
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
        }

        GPSController {
            id: gpsController
            objectName: 'gpsController'
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
