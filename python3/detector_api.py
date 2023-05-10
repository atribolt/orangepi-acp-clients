from tinyrpc.client import RPCClient
from tinyrpc.protocols.jsonrpc import JSONRPCProtocol
from tinyrpc.transports.http import HttpPostClientTransport


class Storage:
  MAP = {}
  
  @staticmethod
  def create(serialized: dict):
    t = serialized.get('type')
    return Storage.MAP.get(t, Storage)().load_from_json(serialized)
  
  def __init__(self, type: str = 'unknown'):
    self.type = type
    
  def to_json(self):
    result = {
      'type': self.type
    }
    self.serialize(result)
    return result
  
  def load_from_json(self, serialized: dict):
    return self
  
  def serialize(self, result: dict):
    pass

    
class TcpStorage(Storage):
  Type = 'tcp'
  Storage.MAP[Type] = lambda: TcpStorage()
  
  def __init__(self, host: str = None, port: int = None):
    super().__init__(TcpStorage.Type)
    self.host = host or 'localhost'
    self.port = port or 9001
  
  def serialize(self, result: dict):
    result['host'] = self.host
    result['port'] = self.port
    
  def load_from_json(self, json: dict):
    self.host = json['host']
    self.port = json['port']
    return self



class Detector:
  class Child:
    def __init__(self, parent: 'Detector'):
      self._parent = parent
      self._data = {}
      self.refresh_data()
    
    @property
    def notify(self):
      return self._parent._client.get_proxy(one_way=True)
    
    @property
    def request(self):
      return self._parent._client.get_proxy(one_way=False)
    
    def refresh_data(self):
      pass
    
  class Adc(Child):
    def __init__(self, parent: 'Detector'):
      super().__init__(parent)
      
    def refresh_data(self):
      self._data = self.request.getAdcInfo()
      
    @property
    def frequency(self) -> int:
      return self._data['frequency']
    
    @property
    def signalBias(self) -> int:
      return self._data['signalBias']
  
    @signalBias.setter
    def signalBias(self, value: int):
      self.notify.tuneAdc({
        'signalBias': value
      })
      
    @property
    def ignorePSS(self) -> bool:
      return self._data['ignorePPS']
      
  class PeakDetector(Child):
    def __init__(self, parent: 'Detector'):
      super().__init__(parent)
      
    def refresh_data(self):
      self._data = self.request.getPeakDetectorInfo()
      
    @property
    def state(self) -> str:
      return self._data['state']
    
    @property
    def riseThreshold(self):
      return self._data['riseThreshold']
    
    @riseThreshold.setter
    def riseThreshold(self, value: int):
      self.notify.tunePeakDetector({
        'riseThreshold': value
      })
      
    @property
    def samplesBeforePeak(self):
      return self._data['msBefore']
      
    @property
    def samplesAfterPeak(self):
      return self._data['msAfter']
    
    @samplesAfterPeak.setter
    def samplesAfterPeak(self, value):
      self.notify.tunePeakDetector({
        'msAfter': value
      })
      
    @property
    def avgAround(self):
      return self._data['avgAround']
    
    @property
    def storage(self):
      return Storage.create(self._data['storage'])
      
    @storage.setter
    def storage(self, s: Storage):
      self.notify.tunePeakDetector({
        'storage': s.to_json()
      })
      
    def start(self):
      self.notify.tunePeakDetector({
        'operation': 'start'
      })
      
    def stop(self):
      self.notify.tunePeakDetector({
        'operation': 'stop'
      })
      
  class Streamer(Child):
    def __init__(self, parent: 'Detector'):
      super().__init__(parent)
      
    def refresh_data(self):
      self._data = self.request.getStreamerInfo()
    
    @property
    def state(self):
      return self._data['state']
    
    @property
    def storage(self):
      return Storage.create(self._data['storage'])
    
    @storage.setter
    def storage(self, s: Storage):
      self.notify.tuneStreamer({
        'storage': s.to_json()
      })
    
    def start(self):
      self.notify.tuneStreamer({
        'operation': 'start'
      })
      
    def stop(self):
      self.notify.tuneStreamer({
        'operation': 'stop'
      })
    
  class ApiVerion:
    def __init__(self, serialized: dict):
      self.core = serialized.get('coreVersion', 'unknown')
      self.detector = serialized.get('detectorVersion', 'unknown')
  
  ###
  _protocol: JSONRPCProtocol
  _transport: HttpPostClientTransport
  _client: RPCClient
    
  def __init__(self, host: str = None, port: int = None) -> None:
    self.connect(host, port)
  
  def connect(self, host: str, port: int):
    if not host or not isinstance(host, str):
      raise ValueError('host required valid string')
    if not port or not isinstance(port, int):
      raise ValueError('port required valid int')
    
    self._protocol = JSONRPCProtocol()
    self._transport = HttpPostClientTransport(f'http://{host}:{port}')
    self._client = RPCClient(self._protocol, self._transport)
  
  def getGps(self) -> dict:
    return self._client.get_proxy().getGpsInfo()
  
  def getAdc(self):
    return Detector.Adc(self)
  
  def getStreamer(self):
    return Detector.Streamer(self)
  
  def getPeakDetector(self):
    return Detector.PeakDetector(self)
  
  def getApiVersion(self):
    return Detector.ApiVerion(self._client.get_proxy().getApiVersion())
