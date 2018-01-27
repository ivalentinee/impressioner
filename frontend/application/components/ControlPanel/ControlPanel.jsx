import React, { Component } from 'react';
import { getSlides } from '../../channels/dataChannel';
import { showSlide } from '../../channels/controlChannel';
import style from './ControlPanel.css';

class ControlPanel extends Component {
  constructor(props) {
    super(props);
    this.state = {
      slides: [],
      currentSlideIndex: null,
    };
  }

  componentDidMount = () => {
    getSlides(data => this.setState({ slides: data.slides }));
  }

  showSlideForIndex = (index) => {
    const { slides } = this.state;
    const slide = slides[index];
    showSlide(slide);
    this.setState({
      currentSlideIndex: index,
    });
  }

  showPrevSlide = () => {
    const { currentSlideIndex } = this.state;
    if (this.canShowPrevSlide()) {
      this.showSlideForIndex(currentSlideIndex - 1);
    }
  }

  showNextSlide = () => {
    const { currentSlideIndex } = this.state;
    if (this.canShowNextSlide()) {
      this.showSlideForIndex(currentSlideIndex + 1);
    }
  }

  canShowPrevSlide = () => {
    const { currentSlideIndex } = this.state;
    return currentSlideIndex > 0;
  };

  canShowNextSlide = () => {
    const { slides, currentSlideIndex } = this.state;
    return currentSlideIndex + 1 < slides.length;
  };

  showFirstSlide = () => {
    this.showSlideForIndex(0);
  }

  renderPreview = () => {
    const { slides, currentSlideIndex } = this.state;
    const currentSlide = slides[currentSlideIndex];

    return (
      <div className={style.preview}>
        <img className={style.image} alt="slide" src={currentSlide} />
      </div>
    );
  }

  render = () => {
    const { slides, currentSlideIndex } = this.state;
    const slideCount = slides.length;

    if (slideCount === 0) {
      return <div className={style.container}>No slides available</div>;
    }

    if (currentSlideIndex === null) {
      return (
        <div className={style.container}>
          <button onClick={this.showFirstSlide}>Start</button>
          <p>{slideCount} slides available</p>
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
          <div className={style.buttons}>
            <button
              className={style.button}
              disabled={!this.canShowPrevSlide()}
              onClick={this.showPrevSlide}
            >
              Prev
            </button>
            <button
              className={style.button}
              disabled={!this.canShowNextSlide()}
              onClick={this.showNextSlide}
            >
              Next
            </button>
          </div>
        </div>
      </div>
    );
  }
}

export default ControlPanel;
