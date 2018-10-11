'use strict';

angular
    .module('menu')
    .controller('MenuController', ['$scope', '$state', function($scope, $state){

        $scope.navigate = function(location){
            $state.go(location);
        };
    }
    ]);
