
module.exports = {
  adc: {
    spectrogram: {
      raw: async (minfreq=0, maxfreq=500000) => {
        let url = new URL(`${document.location.origin}/adc/spectrogram/raw`);
        url.searchParams.set('min-freq', minfreq);
        url.searchParams.set('max-freq', maxfreq);
  
        let response = await fetch(url);
        let result = {
          x: [],
          y: []
        };
  
        if (response.code === 200) {
          let data = response.json();
          result.x = data['x-axis'];
          result.y = data['y-axis'];
        }
  
        return result;
      },
    },
    start: async (mode = 'simulate', srate = 500000) => {
      let url = new URL(`${document.location.origin}/adc/start`);
      url.searchParams.set('mode', mode);
      url.searchParams.set('sample-rate', srate);
      
      let response = await fetch(url, { method: 'POST' });
      return response.ok;
    },
    stop: async () => {
      let url = new URL(`${document.location.origin}/adc/stop`);
      let response = await fetch(url, { method: 'POST' });
      return response.ok;
    },
    info: async () => {
      let url = new URL(`${document.location.origin}/adc/info`);
      let response = await fetch(url);
      return response.json();
    }
  },

  module: {
    info: async () => {
      let url = new URL(`${document.location.origin}/module/info`);
      let response = await fetch(url);
      return response.json();
    }
  },

  gps: {
    info: async () => {
      let url = new URL(`${document.location.origin}/gps/info`);
      let response = await fetch(url);
      return response.json();
    }
  }
}