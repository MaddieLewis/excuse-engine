import GMaps from 'gmaps/gmaps.js';

let coords = [];
let coordinates = document.getElementById('coordinates');
if (coordinates) {
  coordinates = JSON.parse(coordinates.innerHTML);
  coordinates = coordinates.forEach(c => {
    let coo = {lat: parseFloat(c[1]), lng: parseFloat(c[0])};
    coords.push(coo);
  });
}

let pline = document.getElementById('polyline');
if (pline) {
  pline = JSON.parse(pline.innerHTML);
};

console.log(coords);
const mapElement = document.getElementById('map');
if (mapElement) { // don't try to build a map if there's no div#map to inject in
  let map = new GMaps({ el: '#map', lat: 0, lng: 0 });
  const markers = JSON.parse(mapElement.dataset.markers);
  map.addMarkers(markers);
  if (markers.length === 0) {
    map.setZoom(2);
  } else if (markers.length === 1) {
    map.setCenter(markers[0].lat, markers[0].lng);
    map.setZoom(14);
  } else {
    map.fitLatLngBounds(markers);
  }

  map.drawPolyline ({
      path: coords,
      geodesic: true,
      strokeColor: '#FF0000',
      strokeOpacity: 1.0,
      strokeWeight: 2
    });
    map.addControl({
    position: 'right_center',
    content: '<i class="fas fa-location-arrow" style="font-size: 21px;"></i>',
    style: {
      margin: '10px',
      padding: '4px 8px',
      background: '#fff'
    },
    events: {
      click: function(){
        GMaps.geolocate({
          success: function(position){
            map.setCenter(position.coords.latitude, position.coords.longitude);
            map.addMarker({
              lat: position.coords.latitude,
              lng: position.coords.longitude
              });
          },
          error: function(error){
            alert('Geolocation failed: ' + error.message);
          },
          not_supported: function(){
            alert("Your browser does not support geolocation");
          }
        });
      }
    }
  });

  if (pline) {
    pline.forEach(p => {
      console.log(p);
      map.drawPolyline({
        path: google.maps.geometry.encoding.decodePath(p),
        geodesic: true,
        strokeColor: '#FF0000',
        strokeOpacity: 1.0,
        strokeWeight: 2
      });
    });
  }


  // map.setCenter(coords[0].lat, coords[0].lng);
  // map.setZoom(14);

  const button = document.getElementById('traffic');
  if (button) {
    button.addEventListener("click", (event) => {
      if (map.singleLayers.traffic) {
        map.removeLayer('traffic');
      } else {
      map.addLayer('traffic');
      }
    });
  }

  const transit = document.getElementById('transit');
  if (transit) {
    transit.addEventListener("click", (event) => {
      if (map.singleLayers.transit) {
        map.removeLayer('transit');
      } else {
      map.addLayer('transit');
      }
    });
  }

};

