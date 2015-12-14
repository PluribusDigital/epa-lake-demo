app.factory('LakeService',
    function ($http) {
        'use strict';

        var service = {
           error: function (response) {
                console.log('error when calling Lakes API');
                console.log(response);
                return [];
            },

            searchSuccess: function (response) {
                console.log(response.data);
                return response.data.lakes;
                // return response;
            },

            // These methods encapsulate API calls
            typeAheadSearch: function (substring) {
                return $http.post('/queries', {
                    query: "query search($searchString:String!) {lakes(search_string: $searchString){site_id,lakename}}",
                    variables: {'searchString':substring}
                })
                .then(this.searchSuccess, this.error);
            },

            // getDetails: function (product_ndc, success) {
            //     $http.get('/api/v1/drugs/' + product_ndc, {})
            //          .then(function (response) { success(response.data.results[0]); }, this.error);
            // },

        };

        return service;
    });