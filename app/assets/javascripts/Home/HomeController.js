app.controller("HomeController", 
	function ($scope, LakeService, $mdDialog, $mdMedia, $mdSidenav) {

    // list of data files to select; set default
    $scope.files = ["Basin_Landuse_Metrics", "Buffer_Landuse_Metrics", "Chemical_ConditionEstimates", "PHab_IndexValues", "PHab_Metrics_A", "PHab_Metrics_B", "Plankton_OEModel_AnalysisData", "SampledLakeInformation", "WaterQuality"];
    $scope.selectedFile = "SampledLakeInformation";

    // there are a few repetetive/'noise' fields that we want to hide
    $scope.fieldsToHide = ['visits','site_id','visit_no','st'];

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

    // get and display the data once a lake is selected (i.e. via search)
    $scope.selectLake = function(item) {
      if (!U.isBlank(item)) {
        LakeService.get(item.site_id, function(data){
          $scope.lake = data;
          // once selected, load in the selected file for this new lake
          $scope.selectFile($scope.selectedFile);
        }
      );
      }
    }

    // display data for the selected file within the lake
    $scope.selectFile = function(fileName) {
      $scope.fileData = $scope.lake.visits[0][fileName.toLowerCase()];
      // set up an array that will be friendly for generating the table
      $scope.tableData = [];
      angular.forEach($scope.fileData, function(v, k) {
        // filter out a fiew fields we don't want to show
        if ( $scope.fieldsToHide.indexOf(k) == -1 ) { 
          $scope.tableData.push({name:k,value:v});
        }
      });
    }

    // user selects a field to drill down into
    $scope.selectField = function (field_name, ev) {
      $scope.getMeta(field_name);
      $scope.selectedField = field_name;
      showDialog({
        scope: $scope,
        preserveScope: true,
        templateUrl: 'Home/fieldDetailDialog.tmpl.html',
        targetEvent: ev
      });
    }

    // grab the meta data for the selected field
    $scope.getMeta = function (field_name) {
      $scope.meta = null;  // Make sure bindings do not show old data
      LakeService.getMeta(field_name,function(data){
          $scope.meta = data;
        }
      );
    }

    // show the 'about' dialog when selected by user
    $scope.showAbout = function (ev) {
      showDialog({
        templateUrl: 'Home/aboutDialog.tmpl.html',
        targetEvent: ev
      });
    }
    // show the 'about' dialog when selected by user
    $scope.showDevelopers = function (ev) {
      showDialog({
        templateUrl: 'Home/developersDialog.tmpl.html',
        targetEvent: ev
      });
    }

    // shared code to manage a dialog
    showDialog = function(options) {
      // set common options
      options.fullscreen = ($mdMedia('sm') || $mdMedia('xs'));
      options.clickOutsideToClose = true;
      options.controller = DialogController;
      options.parent = angular.element(document.body);
      // show & wire up the dialog
      $mdDialog.show(options)
    }
    function DialogController($scope, $mdDialog) {
      $scope.hide = function() {
        $mdDialog.hide();
      };
      // The global scope `U` is not available for binding in the HTML, but this way it is
      angular.extend($scope, U);
    }

    $scope.toggleNav = function () {
        $mdSidenav('left').toggle();;
    };
});