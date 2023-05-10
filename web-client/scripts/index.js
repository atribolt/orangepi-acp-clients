//@ts-check


const widgets = require('./widgets')
const api = require('./api')


let DRAW_SPECTR_ID = null;


function check_adc() {
  api.adc.info().then((info) => {
    widgets.adc.loadings.state.hidden = true;
    widgets.adc.states.frequency.textContent = `Частота: ${info['sample-rate']} Hz`;
    widgets.adc.states.power.textContent = 'Состояние: ' + info.state;
    widgets.adc.states.type.textContent = 'Режим: ' + info.mode;

    if (info.state === 'started') {
      if (DRAW_SPECTR_ID === null) {
        DRAW_SPECTR_ID = setInterval(load_spectrogram, 1000);
      }
    }
    else {
      if (DRAW_SPECTR_ID !== null) {
        clearInterval(DRAW_SPECTR_ID);
        DRAW_SPECTR_ID = null;
      }
    }
  })
}

function draw_spectrogram(y, x) {
  let ctx = widgets.spectrogram.getContext('2d');

  ctx.reset();
  ctx.translate(widgets.spectrogram.height, 0);
  ctx.scale(1, -1);

  ctx.beginPath();
  ctx.moveTo(0, 0);
  console.log(x)
  for (let i = 0; i < x.length; ++i) {
    ctx.lineTo(i, y[i]);
  }
  ctx.closePath();
  ctx.stroke();
}

function load_spectrogram() {
  api.adc.spectrogram.raw().then((spectr) => {
    draw_spectrogram(spectr.x, spectr.y);
  });
}


function load_module_info() {
  api.module.info().then((info) => {
    let mbinfo = info.motherboard;
    let osinfo = info.os;
    
    let mwidget = widgets.module.states.motherboard;
    mwidget.cpu.name.textContent = 'ЦПУ: ' + mbinfo.cpu.name;
    mwidget.cpu.count.textContent = 'Потоки: ' + mbinfo.cpu.cores;
    mwidget.name.textContent = 'Плата: ' + mbinfo.name;
    mwidget.version.textContent = 'Версия: ' + mbinfo.version;
    mwidget.os.name.textContent = 'ОС: ' + osinfo.name;
    mwidget.os.core.textContent = 'Ядро: ' + osinfo.core.version;
    
    let date = osinfo.time.date;
    let time = osinfo.time.time;
    mwidget.os.time.textContent = `Время: ${date.year}-${date.month}-${date.day} `
    mwidget.os.time.textContent += `${time.hours}:${time.minutes}:${time.seconds}.${time.microseconds}`
    
    widgets.module.loadings.state.hidden = true;
  })
}

function load_gps_info() {
  api.gps.info().then((info) => {
    widgets.gps.states.cheap.textContent = 'Чип: ' + info.name;
    widgets.gps.states.connect.textContent = 'Состояние: ' + info.state;
    widgets.gps.states.velocity.textContent = 'Скорость: ' + info.velocity;
    
    let lon = info.coords.longitude;
    let lat = info.coords.latitude;
    let alt = info.coords.altitude;
    widgets.gps.states.coords.textContent = `Координаты: Lon ${lon}°, Lat ${lat}°, Alt ${alt}°`

    let time = info.time;
    widgets.gps.states.time.textContent = `Время: ${time.hours}:${time.minutes}:${time.seconds}`

    widgets.gps.loadings.state.hidden = true;
  })
}


setInterval(() => { 
  load_module_info(); 
  load_gps_info(); 
}, 2000);

check_adc();

widgets.adc.buttons.start.onclick = (ev) => {
  api.adc.start().then((result) => {
    check_adc();
  });
}
widgets.adc.buttons.stop.onclick = (ev) => {
  api.adc.stop().then((result) => {
    check_adc();
  });
}
