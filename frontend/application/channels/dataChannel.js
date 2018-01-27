import socket from '../utils/socket';

const dataChannel = socket.channel('data', {});
dataChannel.join();

const getSlides = (callback) => {
  dataChannel.push('get slides')
    .receive('ok', callback);
};

export {
  getSlides,
};
