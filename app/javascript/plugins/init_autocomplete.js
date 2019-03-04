import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.querySelectorAll('#location_excuse_start_point, #location_excuse_end_point');
  addressInput.forEach(element => {
    if (element) {
    places({ container: element });
  }
  });
};

export { initAutocomplete };
