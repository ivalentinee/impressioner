import React, { Component } from 'react';
import { onShowSlide } from '../../channels/controlChannel';
import style from './Slides.css'

class Slides extends Component {
  constructor(props) {
    super(props);
    this.state = {
      slide: null,
    };
  }

  componentDidMount = () => {
    onShowSlide(slide => this.setState({
      slide,
    }));
  }

  render = () => {
    const { slide } = this.state;

    if (!slide) {
      return <div className={style.container}>Not started yet...</div>;
    }

    return (
      <div className={style.container}>
        <img className={style.image} alt="slide" src={slide} />
      </div>
    );
  }
}

export default Slides;
