import React, { Component } from 'react';
import socket from '../../utils/socket';

class Slides extends Component {
  componentDidMount = () => {
    const channel = socket.channel('data', {});
    channel.join()
      .receive('ok', resp => console.log('Joined successfully', resp));
    channel.push('get slides')
      .receive('ok', msg => console.log('created message', msg));
  }

  render = () => <div>Slides should be here!</div>
}

export default Slides;
