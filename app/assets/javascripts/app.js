var app = angular.module('hello', [
    'templates', 'ngRoute', 'ngResource', 'directives', 'angular-flash.service',
    'angular-flash.flash-alert-directive', 'ui.bootstrap'
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


