(function () {
    'use strict';
    angular.module('eventDetail', ['ngMaterial'])
        .factory('EventDetail', function ($mdDialog) {
            return {
                show: function (event) {
                    $mdDialog.show({
                        controller: 'EventDetailController',
                        templateUrl: 'src/eventDetail/eventDetail.html',
                        locals: {
                            event: event
                        }
                    });
                }
            }
        });
})();
