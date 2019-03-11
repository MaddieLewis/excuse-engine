import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

// import { initMapbox } from '../plugins/init_mapbox';

import { autocomplete } from '../plugins/init_autocomplete';
import { initLoader } from '../plugins/init_loader';


autocomplete();
initLoader();

// initMapbox();
// import "../views/creative_excuses/show.js.erb";
