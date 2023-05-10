// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0

import QtQuick 2.15
import QtQuick.Window 2.15
import DebugDetectorUI 1.0

Window {
    id: appWindow

    visible: true
    width: 1000
    height: 400

    WindowDebuggingDetector {
        id: wDebug
        visible: true
        width: parent.width
        height: parent.height
    }
}
