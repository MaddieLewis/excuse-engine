
import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
// import { initMapbox } from '../plugins/init_mapbox';


// import { initAutocomplete, } from '../plugins/init_autocomplete';
// initAutocomplete();
const hidden = document.getElementById('clickme');
console.log(hidden)
const button = document.querySelector('#fakebtn');
button.addEventListener('click', (e) => {
  if (document.getElementById('data').dataset.signed == 'true') {
    console.log("CLICKED")
    e.target.innerHTML = 'Saved!';
  }
  setTimeout(function() {
    console.log("HERE")
    hidden.click()
  }, 1000)
});
