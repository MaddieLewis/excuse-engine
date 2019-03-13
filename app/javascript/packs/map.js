// import GMaps from 'gmaps/gmaps.js';
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



  const mapElement = document.getElementById('map');
  function initMap() {
    if (mapElement) {
    let map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: 51.5074, lng: 0.1278},
      zoom: 4,
      mapTypeControl: false,
      gestureHandling: 'cooperative'
    });
    // markers.forEach(marker => {
    //   mark = new google.maps.Marker({
    //     map: map
    //   });
    // });
    var centerControlDiv = document.createElement('div');
    var centerControl = new CenterControl(centerControlDiv, map);

    centerControlDiv.index = 1;
    map.controls[google.maps.ControlPosition.LEFT_BOTTOM].push(centerControlDiv);
    setMarkers(map);
    drawPolyline(map);
    var trafficLayer = new google.maps.TrafficLayer();
    var transitLayer = new google.maps.TransitLayer();

    const button = document.getElementById('traffic');

    if (button) {
      button.addEventListener("click", (event) => {
        if (trafficLayer.getMap() === null) {
          trafficLayer.setMap(map);
        } else {
          trafficLayer.setMap(null);
        }
      });
    }

    const transit = document.getElementById('transit');
    if (transit) {
      transit.addEventListener("click", (event) => {
        if (transitLayer.getMap() === null) {
          transitLayer.setMap(map);
        } else {
          transitLayer.setMap(null);
        }
      });
    }
  }
  };

  function CenterControl(controlDiv, map) {
    // Set CSS for the control border.
    var controlUI = document.createElement('div');
    controlUI.style.backgroundColor = '#fff';
    controlUI.style.border = '2px solid #fff';
    controlUI.style.borderRadius = '3px';
    controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
    controlUI.style.cursor = 'pointer';
    controlUI.style.margin = '16px';
    controlUI.style.textAlign = 'center';
    controlUI.title = 'geolocator';
    controlDiv.appendChild(controlUI);

    // Set CSS for the control interior.
    var controlText = document.createElement('div');
    controlText.style.color = 'rgb(25,25,25)';
    controlText.style.fontFamily = 'Roboto,Arial,sans-serif';
    controlText.style.fontSize = '10px';
    controlText.style.lineHeight = '38px';
    controlText.style.padding = '0px 6px 0px 6px';
    controlText.innerHTML = '<i class="fas fa-location-arrow" style="font-size: 16px;"></i>';
    controlUI.appendChild(controlText);

    // Setup the click event listeners: simply set the map to Chicago.
    controlUI.addEventListener('click', function() {
      navigator.geolocation.getCurrentPosition(function(position) {
        map.setCenter(new google.maps.LatLng(position.coords.latitude, position.coords.longitude))
      });
    });
  };


  function setMarkers(map) {
    if (mapElement) {
    var markers = JSON.parse(mapElement.dataset.markers);
    // Adds markers to the map.

    // Marker sizes are expressed as a Size of X,Y where the origin of the image
    // (0,0) is located in the top left of the image.

    // Origins, anchor positions and coordinates of the marker increase in the X
    // direction to the right and in the Y direction down.
    // var image = {
    //   url: "https://i.ibb.co/D98YX9z/maps-and-flags.png",
    //   // This marker is 20 pixels wide by 32 pixels high.
    //   size: new google.maps.Size(32, 32),
    //   // The origin for this image is (0, 0).
    //   origin: new google.maps.Point(0, 0),
    //   // The anchor for this image is the base of the flagpole at (0, 32).
    //   anchor: new google.maps.Point(0, 0)
    // };
    // Shapes define the clickable region of the icon. The type defines an HTML
    // <area> element 'poly' which traces out a polygon as a series of X,Y points.
    // The final coordinate closes the poly by connecting to the first coordinate.
    // var shape = {
    //   coords: [1, 1, 1, 20, 18, 20, 18, 1],
    //   type: 'poly'
    // };
    var latlngs = []
    for (var i = 0; i < markers.length; i++) {
      var disrupt = markers[i];
      console.log(markers[i].infoWindow);
      var marker = new google.maps.Marker({
        position: markers[i],
        map: map,
        title: disrupt[0],
        zIndex: disrupt[3],
      });
      var latlng = new google.maps.LatLng(markers[i].lat, markers[i].lng)
      var infowindow = new google.maps.InfoWindow({content: markers[i].infoWindow.content });
      marker.addListener('click', function() {
        infowindow.open(map, marker);
      });
      latlngs.push(latlng)
    }


    var latlngbounds = new google.maps.LatLngBounds();
    for (var i = 0; i < latlngs.length; i++) {
      latlngbounds.extend(latlngs[i]);
    }
    if (latlngbounds) {
      map.fitBounds(latlngbounds);
    }
  }
  };

  function drawPolyline(map) {
    if (pline) {
      var line = new google.maps.Polyline ({
        path: google.maps.geometry.encoding.decodePath(pline),
        geodesic: true,
        strokeColor: '#FF0000',
        strokeOpacity: 1.0,
        strokeWeight: 2
      });
    }
     var line = new google.maps.Polyline ({
      path: coords,
      geodesic: true,
      strokeColor: '#FF0000',
      strokeOpacity: 1.0,
      strokeWeight: 2
    });

    line.setMap(map);
  }


// if (mapElement) { // don't try to build a map if there's no div#map to inject in
//   let map = new GMaps({ el: '#map', lat: 0, lng: 0 });
//   const markers = JSON.parse(mapElement.dataset.markers);
//   map.addMarkers(markers);
//   if (markers.length === 0) {
//     map.setZoom(2);
//   } else if (markers.length === 1) {
//     map.setCenter(markers[0].lat, markers[0].lng);
//     map.setZoom(14);
//   } else {
//     map.fitLatLngBounds(markers);
//   }

//
//     map.addControl({
//     position: 'right_center',
//     content: '<i class="fas fa-location-arrow" style="font-size: 21px;"></i>',
//     style: {
//       margin: '10px',
//       padding: '4px 8px',
//       background: '#fff'
//     },
//     events: {
//       click: function(){
//         GMaps.geolocate({
//           success: function(position){
//             map.setCenter(position.coords.latitude, position.coords.longitude);
//             map.addMarker({
//               lat: position.coords.latitude,
//               lng: position.coords.longitude
//               });
//           },
//           error: function(error){
//             alert('Geolocation failed: ' + error.message);
//           },
//           not_supported: function(){
//             alert("Your browser does not support geolocation");
//           }
//         });
//       }
//     }
//   });

//   if (pline) {
//     pline.forEach(p => {
//       console.log(p);
//       map.drawPolyline({
//         path: google.maps.geometry.encoding.decodePath(p),
//         geodesic: true,
//         strokeColor: '#FF0000',
//         strokeOpacity: 1.0,
//         strokeWeight: 2
//       });
//     });
//   }


  // map.setCenter(coords[0].lat, coords[0].lng);
  // map.setZoom(14);


initMap();
setMarkers();
