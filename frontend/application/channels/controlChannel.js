import socket from '../utils/socket';

const controlChannel = socket.channel('control', {});
const join = controlChannel.join();

const showSlide = (slide) => {
  controlChannel.push('show slide', { slide });
};

const onShowSlide = (callback) => {
  join.receive('ok', (response) => { callback(response.slide); });
  controlChannel.on('show slide', data => callback(data.slide));
};

export {
  showSlide,
  onShowSlide,
};
