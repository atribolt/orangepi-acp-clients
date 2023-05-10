import sys

from PySide6.QtWidgets import (
  QApplication,
  QWidget
)
from PySide6.QtCore import (
  QObject
)


class SearchDetectorWindow(QWidget):
  def __init__(self):
    super().__init__()
    
    
  
  
  
  
def main():
  app = QApplication(sys.argv)
  window = SearchDetectorWindow()
  window.show()
  exit(app.exec())


main()