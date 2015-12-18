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

var directives  = angular.module('directives', []);