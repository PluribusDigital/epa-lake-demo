app.controller("HomeController", ['$scope', 'LakeService', 
	function ($scope, LakeService) {

    $scope.lake = null;

    // typeahead search
    $scope.searchPlaceholder = "Find a lake by name"
    $scope.search = function (searchString) {
        if (U.isBlank(searchString)) {return [];}
        var promise = LakeService.search(searchString);
        promise.then(function (data) {
            $scope.noRecords = (data == null || data.length == 0);
        });
        return promise;
    };
    $scope.selectLake = function(item) {
      if (!U.isBlank(item)) {
        $scope.getDetail(item.site_id);
      }
    }

    $scope.getDetail = function (site_id) {
        LakeService.get(site_id, $scope.onLakeLoaded);
    }
    $scope.onLakeLoaded = function (data) {
        $scope.lake = data;
    }

}]);