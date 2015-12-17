app.controller("HomeController", ['$scope', 'LakeService', 
	function ($scope, LakeService) {

    $scope.lake = null;
    $scope.selectedField = null;
    $scope.meta = null;

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

    $scope.selectField = function(field_name) {
        getMeta(field_name);
        $scope.selectedField = field_name;
    }

    $scope.selectLake = function(item) {
      if (!U.isBlank(item)) {
        getDetail(item.site_id);
      }
    }
    getDetail = function (site_id) {
        LakeService.get(site_id, function(data){
                $scope.lake = data;
            }
        );
    }

    getMeta = function (field_name) {
        LakeService.getMeta(field_name,function(data){
                $scope.meta = data.data.meta;
                console.log($scope.meta)
            }
        );
    }

    $scope.selectLake({site_id: 'NLA06608-0175'})

}]);