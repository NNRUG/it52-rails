'use strict';

angular
    .module('eventDetail')
    .controller('EventDetailController', ['$scope','$mdDialog','event', function($scope,$mdDialog, event){
        $scope.event = event;
        $scope.cancel = function() {
            $mdDialog.cancel();
        };
    }
    ]);
