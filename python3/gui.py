import sys
import logging
import subprocess

logging.basicConfig(
  level=logging.DEBUG,
  format='{asctime} [{levelname:^7s}] [{threadName:^10}] {{{name}}} {message}',
  style='{'
)

from PySide6.QtCore import (
  QRectF, QObject
)
from PySide6.QtWidgets import (
  QApplication,
  QWidget
)
from PySide6.QtQml import (
  QQmlEngine,
  QQmlComponent,
  QQmlApplicationEngine
)
from PySide6.QtGui import (
  QGuiApplication,
  QWindow
)

from pathlib import Path
import qml_driver

logging.basicConfig(
  level=logging.DEBUG,
  format='{asctime} [{levelname:^7s}] [{threadName:^10}] {{{name}}} {message}',
  style='{'
)


app = QApplication(sys.argv)
engine = QQmlApplicationEngine()
engine.addImportPath('/home/Work/Projects/orangepi-adc-clients/ui/DebugDetectorUI')
engine.addImportPath('/home/Work/Projects/orangepi-adc-clients/ui/DebugDetectorUI/imports')
engine.addImportPath('/home/Work/Projects/orangepi-adc-clients/ui/DebugDetectorUI/asset_imports')

qml_file = '/home/Work/Projects/orangepi-adc-clients/ui/DebugDetectorUI/content/App.qml'
engine.load(qml_file)

if not engine.rootObjects():
  sys.exit(-1)

qml_driver.load(engine.rootObjects()[0])

app.exec()
