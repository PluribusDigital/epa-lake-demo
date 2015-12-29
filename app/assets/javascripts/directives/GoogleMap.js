var directives = angular.module('directives');

directives.directive("googleMap", ['MapInitializer', function (MapInitializer) {
    return {
        restrict: 'AE',
        link: function (scope, elem, attrs) {
            // Parse HTML attrs, set defaults
            var zoom = Number(attrs.zoom) || 9;
            var showTraffic = (attrs.traffic === "true");
            var lat = Number(attrs.lat) || 38.8976757;
            var lng = Number(attrs.lng) || -77.036528;
            var centerPin = (attrs.centerPin === "true");

            var drawMap = function () {
                // Set up map options
                var gmap = {
                    areaName: '',
                    options: {
                        center: { lat: lat, lng: lng },
                        zoom: zoom,
                        disableDefaultUI: true
                    }
                }
                // draw
                MapInitializer.initialized.then(function () {
                    gmap.map = new google.maps.Map(elem[0], gmap.options);
                    if (showTraffic) {
                        gmap.trafficLayer = new google.maps.TrafficLayer();
                        gmap.trafficLayer.setMap(gmap.map);
                    }
                    if (centerPin) {
                        var marker = new google.maps.Marker({
                            position: { lat: lat, lng: lng },
                            map: gmap.map,
                            title: 'Lake Location'
                        });
                    }
                });

            }
            drawMap();

            attrs.$observe('lat', function () {
                lat = Number(attrs.lat) || 38.8976757;
                drawMap();
            });
            attrs.$observe('lng', function () {
                lng = Number(attrs.lng) || -77.036528;
                drawMap();
            });

        }
    };
}]);