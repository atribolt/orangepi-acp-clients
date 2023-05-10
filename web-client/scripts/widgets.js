module.exports = {
  menu: {
    debug: document.getElementById('menu-debug')
  },
  adc: {
    buttons: {
      start: document.getElementById('btn-adc-start'),
      stop: document.getElementById('btn-adc-stop')
    },
    loadings: {
      state: document.getElementById('loading-adc'),
    },
    states: {
      power: document.getElementById('state-adc-enable'),
      frequency: document.getElementById('state-adc-frequency'),
      type: document.getElementById('state-adc-type')
    }
  },

  module: {
    loadings: {
      state: document.getElementById('loading-module')
    },
    states: {
      motherboard: {
        name: document.getElementById('state-module-motherboard-name'),
        version: document.getElementById('state-module-motherboard-version'),
        cpu: {
          name: document.getElementById('state-module-cpu'),
          count: document.getElementById('state-module-cpu-count')
        },
        os: {
          name: document.getElementById('state-module-os'),
          core: document.getElementById('state-module-core'),
          time: document.getElementById('state-module-time')
        }
      }
    }
  },

  gps: {
    loadings: {
      state: document.getElementById('loading-gps')
    },
    states: {
      cheap: document.getElementById('state-gps-cheap'),
      connect: document.getElementById('state-gps-connect'),
      coords: document.getElementById('state-gps-coords'),
      velocity: document.getElementById('state-gps-velocity'),
      time: document.getElementById('state-gps-time')
    }
  },

  spectrogram: document.getElementById('spectrogram')
}