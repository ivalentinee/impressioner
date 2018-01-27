import React from 'react';
import ReactDOM from 'react-dom';

export default (elementId, Component) => {
  document.addEventListener('DOMContentLoaded', () => {
    const element = document.getElementById(elementId);
    if (element) {
      ReactDOM.render(<Component />, element);
    }
  });
};
