const setKeypressHandlers = (model) => {
  const keyDownTextField = (event) => {
    const { keyCode } = event;
    switch (keyCode) {
      case 13:
        model.start();
        break;
      case 88:
        model.reset();
        break;
      case 37:
        model.showPrevSlide();
        break;
      case 80:
        model.showPrevSlide();
        break;
      case 39:
        model.showNextSlide();
        break;
      case 78:
        model.showNextSlide();
        break;
      default:
        break;
    }
  };

  document.addEventListener('keydown', keyDownTextField, false);
};

export default setKeypressHandlers;
