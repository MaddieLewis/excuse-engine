
import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import { initAutocomplete } from '../plugins/init_autocomplete';
import { initMapbox } from '../plugins/init_mapbox';

import { saved, } from './saved';

initMapbox();
initAutocomplete();

// import "../views/creative_excuses/show.js.erb";
