function showLocation(){
        var map = L.map('map').setView([49.437820, 32.058959], 13);

        L.tileLayer('https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png', {
            maxZoom: 18,
            attribution: name,
            id: 'examples.map-i875mjb7'
        }).addTo(map);

        L.marker(latlng).addTo(map)
                .bindPopup("<b>" + name +"</b><br/>Категория: " + type);
    }

function addLocation() {
  var map = L.map('map').setView([49.437820, 32.058959], 13);

    L.tileLayer('https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png', {
        maxZoom: 18,
        id: 'examples.map-i875mjb7'
    }).addTo(map);

    var marker;
    if (presence == true) {
        marker = addMarker(latlng[0], latlng[1]);
    }

    function onMapClick(e) {
        if (marker != null) {
            map.removeLayer(marker);
        }
        marker = addMarker(e.latlng.lat, e.latlng.lng);
    }

    map.on('click', onMapClick);

    function addMarker(lat, lng) {
        var new_marker = new L.Marker([lat, lng], { draggable:true });
        map.addLayer(new_marker);
        $.ajax({
            url: "/get_location",
            type: "post",
            data : 'latitude=' + lat + '&longitude=' + lng
        });
        return new_marker;
    }
}