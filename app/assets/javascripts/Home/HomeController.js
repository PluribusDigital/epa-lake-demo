app.controller("HomeController", 
	function ($scope, LakeService, $mdDialog, $mdMedia) {

    $scope.files = ["Basin_Landuse_Metrics", "Buffer_Landuse_Metrics", "Chemical_ConditionEstimates", "MeanDO_ConditionEstimate", "MeanDO_Data", "PHab_CondtionEstimates", "PHab_IndexValues", "PHab_Metrics_A", "PHab_Metrics_B", "Plankton_OEModel_AnalysisData", "Plankton_OEModel_ConditionEstimates", "Plankton_OEModel_ValidSitesUsed", "Profile", "Recreational_ConditionEstimates", "SampledLakeInformation", "Secchi", "Trophic_ConditionEstimate", "WaterQuality"];
    $scope.selectedFile = "SampledLakeInformation";
    $scope.tableData = null;
    $scope.selectedField = null;
    $scope.meta = null;
    $scope.seriesData = [
        {label:'foo',value:10},
        {label:'bar',value:20}
    ]
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
    function DialogController($scope, $mdDialog) {
      $scope.hide = function() {
        $mdDialog.hide();
      };
    }
    getMeta = function (field_name) {
        LakeService.getMeta(field_name,function(data){
                $scope.meta = data;
                console.log($scope.meta.values)
            }
        );
    }

    $scope.selectLake = function(item) {
      if (!U.isBlank(item)) {
        LakeService.get(item.site_id, function(data){
          $scope.tableData = fieldsToTableArray(data);
          $scope.lake = data;
        }
      );
      }
    }

    $scope.selectFile = function(fileName) {
      $scope.tableData = fieldsToTableArray($scope.lake.visits[0][fileName.toLowerCase()]);
    }

    fieldsToTableArray = function(object) {
      // change data from object to array, friendly format for table
      var dataArray = [];
      angular.forEach(object, function(v, k) {
        this.push({name:k,value:v});
      }, dataArray);
      return dataArray;
    }

    

    $scope.selectLake({site_id: 'NLA06608-0175'})

});