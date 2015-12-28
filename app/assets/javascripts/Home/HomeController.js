app.controller("HomeController", 
	function ($scope, LakeService, $mdDialog, $mdMedia) {

    $scope.files = ["Basin_Landuse_Metrics", "Buffer_Landuse_Metrics", "Chemical_ConditionEstimates", "PHab_IndexValues", "PHab_Metrics_A", "PHab_Metrics_B", "Plankton_OEModel_AnalysisData", "SampledLakeInformation", "WaterQuality"];
    $scope.selectedFile = "SampledLakeInformation";
    $scope.tableData = null;
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

    $scope.selectField = function (field_name, ev) {
        $scope.getMeta(field_name);
        $scope.selectedField = field_name;
        $scope.dialogFullscreen = $mdMedia('xs') || $mdMedia('sm');
        var useFullScreen = ($mdMedia('sm') || $mdMedia('xs'))  && $scope.dialogFullscreen;
        $mdDialog.show({
          controller: DialogController,
          scope: $scope,
          preserveScope: true,
          templateUrl: 'Home/fieldDetailDialog.tmpl.html',
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

    $scope.aboutShow = function (ev) {
        $scope.dialogFullscreen = $mdMedia('xs') || $mdMedia('sm');
        var useFullScreen = ($mdMedia('sm') || $mdMedia('xs'))  && $scope.dialogFullscreen;
        $mdDialog.show({
          controller: DialogController,
          templateUrl: 'Home/aboutDialog.tmpl.html',
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

      // The global scope `U` is not available for binding in the HTML, but this way it is
      angular.extend($scope, U);
    }

    $scope.getMeta = function (field_name) {
        $scope.meta = null;  // Make sure bindings do not show old data
        LakeService.getMeta(field_name,function(data){
                $scope.meta = data;
            }
        );
    }

    $scope.selectLake = function(item) {
      if (!U.isBlank(item)) {
        LakeService.get(item.site_id, function(data){
          $scope.lake = data;
          // load in the selected file for thisn new lake
          $scope.selectFile($scope.selectedFile);
        }
      );
      }
    }

    $scope.selectFile = function(fileName) {
      $scope.fileData = $scope.lake.visits[0][fileName.toLowerCase()];
      $scope.tableData = [];
      angular.forEach($scope.fileData, function(v, k) {
        if (k !== "visits") { 
          $scope.tableData.push({name:k,value:v});
        }
      });
    }

    $scope.selectLake({site_id: 'NLA06608-0045'})

});