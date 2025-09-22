<!DOCTYPE html>
<html>
<head>
    <title>Live Trip Share</title>
    <style>
        #map {
            height: 400px;
            width: 100%;
        }
    </style>
</head>
<body>
    <h1>Live Trip Location</h1>
    <div id="map"></div>

    <script>
        let map;
        let marker;

        function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: -34.397, lng: 150.644 },
                zoom: 8
            });

            marker = new google.maps.Marker({
                map: map,
                title: 'Driver Location'
            });

            fetchDriverLocation();
            setInterval(fetchDriverLocation, 5000); // Refresh every 5 seconds
        }

        function fetchDriverLocation() {
            // No longer needed, as we'll use websockets
        }

        window.Echo.private('trip.{{ $trip->id }}')
            .listen('DriverLocationUpdated', (e) => {
                console.log(e);
                const location = e.tripRequest.driver.location;
                const newPosition = { lat: location.latitude, lng: location.longitude };
                marker.setPosition(newPosition);
                map.panTo(newPosition);
            });
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_GOOGLE_MAPS_API_KEY&callback=initMap" async defer></script>
    <script src="{{ asset('js/app.js') }}"></script>
</body>
</html>
