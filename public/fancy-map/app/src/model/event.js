(function () {
    'use strict';

    angular.module('it52.info').service('Event', ['$http', function ($http) {

        var eventUrl = 'http://www.it52.info/api/v1/events?callback=JSON_CALLBACK';
        var oneEventUrl = 'http://www.it52.info/api/v1/events/{0}?callback=JSON_CALLBACK';

        function loadAll() {
            return $http.jsonp(eventUrl).then(function (result) {
                return result.data;
            });
        }

        return {
            getEvents: function () {
                return loadAll();
            },
            getEvent: function (id) {
                var url = oneEventUrl.replace('{0}', id);
                return $http.jsonp(url).then(function (result) {
                    return result.data;
                });
            }

        };
    }]);
}());