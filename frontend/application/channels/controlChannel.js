import socket from '../utils/socket';

const controlChannel = socket.channel('control', {});
controlChannel.join();

const showSlide = (slide) => {
  controlChannel.push('show slide', { slide });
};

const onShowSlide = (callback) => {
  controlChannel.on('show slide', data => callback(data.slide));
};

export {
  showSlide,
  onShowSlide,
};
