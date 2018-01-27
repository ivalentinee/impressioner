import Slides from './Slides';
import renderComponentById from '../../utils/renderComponentById';
import model from '../../models/Slides';

renderComponentById('slides', Slides, { model });
