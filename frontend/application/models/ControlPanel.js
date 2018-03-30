import { observable, computed, action, autorun } from 'mobx';
import { getSlides } from '../channels/dataChannel';
import { showSlide, onShowSlide } from '../channels/controlChannel';
import setKeyPressHandlers from './ControlPanel/setKeypressHandlers';

class ControlPanel {
  @observable slides = [];
  @observable currentSlide = null;

  constructor() {
    autorun('send current slide change', () => {
      if (this.currentSlide) {
        showSlide(this.currentSlide);
      }
    });
  }

  @computed get slideCount() { return this.slides.length; }
  @computed get currentSlideIndex() {
    return this.slides.findIndex(slide => slide === this.currentSlide);
  }
  @computed get canShowPrevSlide() { return this.currentSlideIndex > 0; }
  @computed get canShowNextSlide() { return this.currentSlideIndex + 1 < this.slides.length; }

  @action start = () => {
    if (!this.currentSlide) {
      [this.currentSlide] = this.slides;
    }
  }

  @action showPrevSlide = () => {
    if (this.canShowPrevSlide) {
      const prevSlide = this.slides[this.currentSlideIndex - 1];
      showSlide(prevSlide);
    }
  }

  @action showNextSlide = () => {
    if (this.canShowNextSlide) {
      const nextSlide = this.slides[this.currentSlideIndex + 1];
      showSlide(nextSlide);
    }
  }

  @action setSlide = (slide) => {
    if (this.currentSlide !== slide) { this.currentSlide = slide; }
  }

  @action reset = () => {
    showSlide(null);
  }
}

const model = new ControlPanel();

getSlides((data) => { model.slides = data.slides; });
onShowSlide(slide => model.setSlide(slide));
setKeyPressHandlers(model);

export default model;
