from PySide6.QtQml import (
  QQmlEngine,
  QQmlComponent,
  QQmlApplicationEngine,
  QmlElement
)
from PySide6.QtCore import (
  Signal,
  Slot,
  QObject
)
from PySide6.QtCharts import (
  QAbstractSeries
)

import logging
import socket
import numpy as np
import socket
import struct

# from detector_api import Detector


QML_IMPORT_NAME = 'DebugDetectorUI'
QML_IMPORT_MAJOR_VERSION = 2


@QmlElement
class Data(QObject):
  def __init__(self, host, port):
    super().__init__(None)
    self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    self.sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
    self.sock.bind((host, port))
    self.sock.listen(10)
    
  
  def updateView():
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
    sock.bind(('0.0.0.0', 9999))
    
    sock.listen(10)
    
    conn, addr = sock.accept()
    conn.settimeout(1)
    
    buffer = b''
    df = 'IIhh'
    psize = 12
    recvpcount = 3000
    
    while not QThread.currentThread().isInterruptionRequested():
      try:
        buffer += conn.recv(psize * recvpcount)
      except TimeoutError:
        continue
      except Exception as ex:
        logging.getLogger('recieve loop').exception('exception', exc_info=ex)
      
      count = len(buffer) // psize
      data = buffer[:count * psize]
      
      if len(data) > psize:
        packets = np.array(struct.unpack(df * count, data), dtype=np.int32).reshape((4, count))
        line = signalViewer.series(0)
        line.replace(packets[:, 2])
        buffer = buffer[count * psize:]
    
    sock.close()
