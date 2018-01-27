import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { observer } from 'mobx-react';
import style from './Slides.css';

@observer
class Slides extends Component {
  render = () => {
    const { slide } = this.props.model;

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

Slides.propTypes = {
  model: PropTypes.shape({
    slide: PropTypes.string,
  }),
};

export default Slides;
