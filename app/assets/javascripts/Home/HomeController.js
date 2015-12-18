app.controller("HomeController", 
	function ($scope, LakeService, $mdDialog, $mdMedia) {

    $scope.lakeData = null;
    $scope.selectedField = null;
    $scope.meta = null;
    // $scope.selected = [];

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

    $scope.selectField = function(field_name,ev) {
        getMeta(field_name);
        $scope.selectedField = field_name;
        $scope.dialogFullscreen = $mdMedia('xs') || $mdMedia('sm');
        var useFullScreen = ($mdMedia('sm') || $mdMedia('xs'))  && $scope.dialogFullscreen;
        $mdDialog.show({
          controller: DialogController,
          scope: $scope,
          templateUrl: 'Home/dialog1.tmpl.html',
          parent: angular.element(document.body),
          targetEvent: ev,
          clickOutsideToClose:true,
          fullscreen: useFullScreen
        })
        $scope.$watch(function() {
          return $mdMedia('xs') || $mdMedia('sm');
        }, function(wantsFullScreen) {
          $scope.dialogFullscreen = (wantsFullScreen === true);
        });
    }
    function DialogController($scope, $mdDialog) {
      $scope.hide = function() {
        $mdDialog.hide();
      };
    }

    $scope.selectLake = function(item) {
      if (!U.isBlank(item)) {
        getDetail(item.site_id);
      }
    }
    getDetail = function (site_id) {
        LakeService.get(site_id, function(data){
                // change data from object to array
                var dataArray = [];
                angular.forEach(data, function(v, k) {
                  this.push({name:k,value:v});
                }, dataArray);
                $scope.lakeData = dataArray;
                $scope.lake = data;
            }
        );
    }

    getMeta = function (field_name) {
        LakeService.getMeta(field_name,function(data){
                $scope.meta = data.data.meta;
            }
        );
    }

    $scope.selectLake({site_id: 'NLA06608-0175'})

});