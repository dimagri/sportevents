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