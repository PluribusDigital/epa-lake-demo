var app = angular.module('lakedata', 
  [ 'templates', 'ngRoute', 'ngResource', 'ngMaterial', 
    'md.data.table', 'directives'
]);

app.config([
'$routeProvider', function ($routeProvider) {
    return $routeProvider.when('/', {
        templateUrl: "Home/Home.html",
        controller: 'HomeController'
    })
}
]);

var directives = angular.module('directives', []);

app.factory('MapInitializer', function ($rootScope, $window, $q) {
    //Google's url for async maps initialization accepting callback function
    var asyncUrl = 'https://maps.googleapis.com/maps/api/js?callback=',
        deferred = $q.defer();

    //Callback function - resolving promise after maps successfully loaded
    $window.googleMapsInitialized = deferred.resolve;

    //Async loader
    var asyncLoad = function (asyncUrl, callbackName) {
        var script = document.createElement('script');
        //script.type = 'text/javascript';
        script.src = asyncUrl + callbackName;
        document.body.appendChild(script);
    };

    //Start loading google maps
    asyncLoad(asyncUrl, 'googleMapsInitialized');

    //Usage: MapInitializer.initialized.then(callback)
    return {
        initialized: deferred.promise
    };
});
