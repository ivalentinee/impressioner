import { observable, computed, action, autorun } from 'mobx';
import { getSlides } from '../channels/dataChannel';
import { showSlide } from '../channels/controlChannel';

class ControlPanel {
  @observable slides = [];
  @observable currentSlideIndex = null;

  constructor() {
    autorun('send current slide change', () => {
      if (this.currentSlide) {
        showSlide(this.currentSlide);
      }
    });
  }

  @computed get slideCount() { return this.slides.length; }
  @computed get currentSlide() { return this.slides[this.currentSlideIndex]; }
  @computed get canShowPrevSlide() { return this.currentSlideIndex > 0; }
  @computed get canShowNextSlide() { return this.currentSlideIndex + 1 < this.slides.length; }

  @action showFirstSlide = () => {
    this.currentSlideIndex = 0;
  }

  @action showPrevSlide = () => {
    if (this.canShowPrevSlide) this.currentSlideIndex -= 1;
  }

  @action showNextSlide = () => {
    if (this.canShowNextSlide) this.currentSlideIndex += 1;
  }
}

const model = new ControlPanel();

getSlides((data) => { model.slides = data.slides; });

export default model;
