import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { observer } from 'mobx-react';
import style from './ControlPanel.css';

@observer
class ControlPanel extends Component {
  renderPreview = () => {
    const { currentSlide } = this.props.model;

    return (
      <div className={style.preview}>
        <img className={style.image} alt="slide" src={currentSlide} />
      </div>
    );
  }

  render = () => {
    const {
      currentSlideIndex, slideCount, currentSlide,
      showFirstSlide, showPrevSlide, showNextSlide,
      canShowPrevSlide, canShowNextSlide,
    } = this.props.model;

    if (slideCount === 0) {
      return <div className={style.container}>No slides available</div>;
    }

    if (!currentSlide) {
      return (
        <div className={style.container}>
          <button className={style.button} onClick={showFirstSlide}>Start</button>
          <div className={style.status}>{slideCount} slides available</div>
        </div>
      );
    }

    return (
      <div className={style.container}>
        {this.renderPreview()}
        <div className={style.controls}>
          <div className={style.status}>
            Current slide: {currentSlideIndex + 1}/{slideCount}
          </div>
          <div className={style.controlButtons}>
            <button
              className={style.button}
              disabled={!canShowPrevSlide}
              onClick={showPrevSlide}
            >
              &lt;
            </button>
            <button
              className={style.button}
              disabled={!canShowNextSlide}
              onClick={showNextSlide}
            >
              &gt;
            </button>
          </div>
        </div>
      </div>
    );
  }
}

ControlPanel.propTypes = {
  model: PropTypes.shape({
    currentSlide: PropTypes.string,
    currentSlideIndex: PropTypes.number,
    slideCount: PropTypes.number.isRequired,
    showFirstSlide: PropTypes.func.isRequired,
    showPrevSlide: PropTypes.func.isRequired,
    showNextSlide: PropTypes.func.isRequired,
    canShowPrevSlide: PropTypes.bool.isRequired,
    canShowNextSlide: PropTypes.bool.isRequired,
  }),
};

export default ControlPanel;
