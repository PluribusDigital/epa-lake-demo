app.controller("HomeController", ['$scope', 'LakeService', 
	function ($scope, lakeService) {
	
	window.ss = lakeService.typeAheadSearch('ho');

}]);
