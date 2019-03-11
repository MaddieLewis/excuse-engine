// import places from 'places.js';

// const initAutocomplete = () => {
//   const addressInput = document.querySelectorAll('#location_excuse_start_point, #location_excuse_end_point');
//   addressInput.forEach(element => {
//     if (element) {
//     places({ container: element });
//   }
//   });
// };

// export { initAutocomplete };

function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var addresses = document.querySelectorAll('#location_excuse_start_point, #location_excuse_end_point, #reported_excuse_address');
    addresses.forEach (address => {
      if (address) {
        var autocomplete = new google.maps.places.Autocomplete(address, { types: [ 'geocode' ] });
         autocomplete.setComponentRestrictions(
            {'country': ['gb']});
        google.maps.event.addDomListener(address, 'keydown', function(e) {
          if (e.key === "Enter") {
            e.preventDefault(); // Do not submit the form on Enter.
          }
        });
      }
    });
  });
}

export { autocomplete };
