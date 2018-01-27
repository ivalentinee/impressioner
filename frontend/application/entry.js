/* eslint-disable react/jsx-filename-extension */

import 'phoenix_html';
import renderComponentById from './utils/renderComponentById';
import { Slides } from './components/Slides';
import { ControlPanel } from './components/ControlPanel';

renderComponentById('slides', Slides);
renderComponentById('control_panel', ControlPanel);
