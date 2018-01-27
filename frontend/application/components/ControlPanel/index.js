import ControlPanel from './ControlPanel';
import renderComponentById from '../../utils/renderComponentById';
import model from '../../models/ControlPanel';

renderComponentById('control_panel', ControlPanel, { model });
