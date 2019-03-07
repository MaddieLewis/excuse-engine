import mapboxgl from 'mapbox-gl';

let coordinates = document.getElementById('coordinates');
if (coordinates) {
  coordinates = JSON.parse(coordinates.innerHTML);
}
// console.log(coordinates);

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  const fitMapToLine = (map, lineCoords) => {
    const bounds = new mapboxgl.LngLatBounds();
    lineCoords.forEach(coords => bounds.extend([coords[0], coords[1]]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
  }

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxapikey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/madz/cjsx5f2m92iu31frv61mfq1ih',
      center: [-0.07711901911, 51.53263963289],
      zoom: 10
    });

    map.on('load', function () {
      map.addLayer({
        "id": "route",
        "type": "line",
        "source": {
          "type": "geojson",
          "data": {
            "type": "Feature",
            "properties": {},
            "geometry": {
              "type": "LineString",
              "coordinates": coordinates
            }
          }
        },
        "layout": {
          "line-join": "round",
          "line-cap": "round"
        },
        "paint": {
          "line-color": "#9CF0F5",
          "line-width": 5,
          "line-opacity": .8
        }
      });
    });
    fitMapToLine(map, coordinates);
  }
};

export { initMapbox };
