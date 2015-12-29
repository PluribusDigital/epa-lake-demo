
app.controller('googleMapController', function ($scope, MapInitializer) {
    /************************************************************************************************
    * Main Methods
    */

    $scope.drawMap = function () {
        // Set up map options
        var gmap = {
            areaName: '',
            options: {
                center: {
                    lat: $scope.lat,
                    lng: $scope.lng
                },
                zoom: $scope.zoom,
                disableDefaultUI: true
            }
        }

        gmap.map = new google.maps.Map($scope.node, gmap.options);
        if ($scope.showTraffic) {
            gmap.trafficLayer = new google.maps.TrafficLayer();
            gmap.trafficLayer.setMap(gmap.map);
        }
        if ($scope.centerPin) {
            var marker = new google.maps.Marker({
                position: { lat: $scope.lat, lng: $scope.lng },
                map: gmap.map,
                title: 'Lake Location'
            });
        }
    };

    /************************************************************************************************
     * Events
     */

    $scope.onAttributesChanged = function () {
        $scope.drawMap();
    };

    /* Issue #12 - The MapInitializer needs to be present in the controller dependencies so that the 
     MapInitializer sequence is begun, but including the below code causes the undesirable 
     'no first load' behvaior */
    //MapInitializer.initialized.then($scope.drawMap);
});

var directives = angular.module('directives');

directives.directive("googleMap", function () {
    return {
        restrict: 'AE',
        scope: {
            // TODO:  `=?` is the notation for optional binding
            zoom: "=",
            showTraffic: "=",
            lat: "=",
            lng: "=",
            centerPin: "="
        },
        controller: 'googleMapController',
        link: function (scope, elem, attrs) {
            /* TODO: Set missing values when using optional binding
            scope.zoom = attrs['zoom'] || 9;
            scope.showTraffic = attrs['showTraffic'] || false;
            scope.lat = attrs['lat'] || 38.8976757;
            scope.lng = attrs['lng'] || -77.036528;
            scope.centerPin = attrs['centerPin'] || true;
            */

            // Bind this scope to its container in the DOM
            scope.node = elem[0];

            // watch for the values to bind
            scope.$watch('lat', function (newValue, oldValue) {
                if (newValue)
                    scope.onAttributesChanged();
            });

            scope.$watch('lng', function (newValue, oldValue) {
                if (newValue)
                    scope.onAttributesChanged();
            });
        }
    };
});