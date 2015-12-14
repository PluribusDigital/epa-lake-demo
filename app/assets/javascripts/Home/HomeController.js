app.controller("HomeController", ['$scope', 'LakeService', 
	function ($scope, lakeService) {

    $scope.searchPlaceholder = "Find a lake by name"
	
    $scope.search = function (searchString) {
        if (U.isBlank(searchString)) {return [];}
        var promise = lakeService.typeAheadSearch(searchString);
        promise.then(function (data) {
            $scope.noRecords = (data == null || data.length == 0);
        });
        return promise;
    };

}]);