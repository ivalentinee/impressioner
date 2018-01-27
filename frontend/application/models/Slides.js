import { observable } from 'mobx';
import { onShowSlide } from '../channels/controlChannel';

class Slides {
  @observable slide = null;
}

const model = new Slides();

onShowSlide((slide) => { model.slide = slide; });

export default model;
