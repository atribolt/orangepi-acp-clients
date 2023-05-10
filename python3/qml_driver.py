# from PySide6.QtQml import (
#   QQmlEngine,
#   QQmlComponent,
#   QQmlApplicationEngine,
#   QmlElement
# )
# from PySide6.QtCore import (
#   Signal,
#   Slot,
#   # QObject
# )
import logging
import socket

from detector_api import Detector
#
#
# QML_IMPORT_NAME = 'DebugDetectorUI'
# QML_IMPORT_MAJOR_VERSION = 2

#
# @QmlElement
# class DetectorDriver(QObject):
#   def __init__(self, parent=None):
#     super().__init__(parent)
#     self.detector = Detector()
#     self.adcInfo = self.detector.getAdcInfo()
#     self.detectorInfo = self.detector.getPeakDetectorInfo()
#     self.streamerInfo = self.detector.getStreamerInfo()
#
#   @Slot
#   def setHostPort(self, host, port):
#     self.detector = Detector(host, port)
#
#   @Slot(result=int)
#   def adcFrequency(self) -> int:
#     self.adcInfo.refresh_data()
#     return self.adcInfo.frequency
#
#   @Slot()
#   def startPeakDetector(self):
#     self.detectorInfo.start()
#
#   @Slot()
#   def stopPeakDetector(self):
#     self.detectorInfo.stop()
#
#   @Slot(int)
#   def setRiseThreshold(self, value):
#     self.detectorInfo.riseThreshold = value
#
#

from PySide6.QtCore import QObject, QThread
from PySide6.QtCharts import QXYSeries, QChartView

from detector_api import Detector, TcpStorage
import subprocess

DETECTOR: Detector = None

rootObject: QObject
orangeController: QObject
adcController: QObject
pdController: QObject
streamerController: QObject
gpsController: QObject
signalViewer: QObject


def checkHost(host):
  try:
    subprocess.check_call(['ping', '-c', '1', host], stdout=subprocess.DEVNULL)
    hostAvailable = True
  except:
    hostAvailable = False

  orangeController.setProperty('hostAvailable', hostAvailable)


def loadVersion(host, port):
  INVALID_VERSION = 'unknown'
  
  global DETECTOR
  try:
    DETECTOR = Detector(host, port)
    version = DETECTOR.getApiVersion().core or INVALID_VERSION
  except:
    version = INVALID_VERSION

  orangeController.setProperty('softwareVersion', version)


def disconnectSignals():
  adcController.signalBiasValueChanged.disconnect(setAdcBias)
  pdController.isEnabledChanged.disconnect(peakDetectorPowerSwitch)
  pdController.riseThresholdChanged.disconnect(riseThresholdChanged)
  pdController.samplesRightChanged.disconnect(samplesRightChanged)
  pdController.storageChanged.disconnect(peakStorageChanged)
  streamerController.isEnabledChanged.disconnect(streamerPowerChanged)
  streamerController.storageChanged.disconnect(streamerStorageChanged)


def connectSignals():
  adcController.signalBiasValueChanged.connect(setAdcBias)
  pdController.isEnabledChanged.connect(peakDetectorPowerSwitch)
  pdController.riseThresholdChanged.connect(riseThresholdChanged)
  pdController.samplesRightChanged.connect(samplesRightChanged)
  pdController.storageChanged.connect(peakStorageChanged)
  streamerController.isEnabledChanged.connect(streamerPowerChanged)
  streamerController.storageChanged.connect(streamerStorageChanged)


def loadInfo():
  disconnectSignals()
  
  info = DETECTOR.getAdc()
  adcController.setProperty('frequency', info.frequency)
  adcController.setProperty('usePPS', not info.ignorePSS)
  adcController.setProperty('signalBiasValue', info.signalBias)
  
  info = DETECTOR.getPeakDetector()
  pdController.setProperty('isEnabled', info.state == 'started')
  pdController.setProperty('riseThreshold', info.riseThreshold)
  pdController.setProperty('samplesLeft', info.samplesBeforePeak)
  pdController.setProperty('samplesRight', info.samplesAfterPeak)
  pdController.setProperty('avgAround', info.avgAround)

  storage = info.storage
  if isinstance(storage, TcpStorage):
    pdController.setProperty('storageHost', storage.host)
    pdController.setProperty('storagePort', storage.port)

  info = DETECTOR.getStreamer()
  streamerController.setProperty('isEnabled', info.state == 'started')
  
  storage = info.storage
  if isinstance(storage, TcpStorage):
    streamerController.setProperty('storageHost', storage.host)
    streamerController.setProperty('storagePort', storage.port)

  coords = DETECTOR.getGps()
  # gpsController.setProperty('longitude', coords['lon'])
  # gpsController.setProperty('latitude', coords['lat'])
  # gpsController.setProperty('altitude', coords['alt'])
  
  connectSignals()


def setAdcBias():
  signalBias = adcController.property('signalBiasValue')
  DETECTOR.getAdc().signalBias = signalBias
  
  
def peakDetectorPowerSwitch():
  power = pdController.property('isEnabled')
  if power:
    DETECTOR.getPeakDetector().start()
  else:
    DETECTOR.getPeakDetector().stop()
  

def riseThresholdChanged():
  rth = pdController.property('riseThreshold')
  DETECTOR.getPeakDetector().riseThreshold = rth
  signalViewer.setProperty('riseThreshold', rth)
  

def samplesRightChanged():
  samples = pdController.property('samplesRight')
  DETECTOR.getPeakDetector().riseThreshold = samples
  

def peakStorageChanged(host, port):
  DETECTOR.getPeakDetector().storage = TcpStorage(host, port)

def streamerPowerChanged():
  power = streamerController.property('isEnabled')
  global thread
  if power:
    # thread = QThread()
    # thread.started.connect(signalRecieverLoop)
    # thread.start()
    DETECTOR.getStreamer().start()
  else:
    DETECTOR.getStreamer().stop()
    # thread.quit()
    # thread.wait(1000)
    # thread.terminate()


def streamerStorageChanged(host, port):
  DETECTOR.getStreamer().storage = TcpStorage(host, port)


def load(rootQmlObject: QObject):
  global rootObject, adcController, pdController, streamerController, gpsController, orangeController, signalViewer
  
  rootObject = rootQmlObject
  orangeController = rootQmlObject.findChild(object, 'orangeController')
  adcController = rootQmlObject.findChild(object, 'adcController')
  pdController = rootQmlObject.findChild(object, 'peakDetectorController')
  streamerController = rootQmlObject.findChild(object, 'streamerController')
  gpsController = rootQmlObject.findChild(object, 'gpsController')
  signalViewer = rootQmlObject.findChild(QObject, 'spectrogram')
  
  # signalViewer = rootQmlObject.findChild(object, 'signalViewer')
  
  orangeController.hostPortChanged.connect(checkHost)
  orangeController.hostPortChanged.connect(loadVersion)
  orangeController.loadDetectorInfo.connect(loadInfo)
  connectSignals()
  
  