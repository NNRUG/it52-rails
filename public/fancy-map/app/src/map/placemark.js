(function () {
    'use strict';

    angular.module('map').service('Placemark', ['$q', 'Event', function ($q, Event) {
        var STUB = [{
            lng: 44.006265,
            lat: 56.322584,
            layer: 'company',
            message: "Yandex",
            icon: {
                type: 'extraMarker',
                icon: 'fa-beer',
                markerColor: 'red',
                prefix: 'fa',
                shape: 'star'
            }
        }, {
            lng: 43.994991,
            lat: 56.330452,
            layer: 'company',
            message: "SmartBICS",
            icon: {
                type: 'extraMarker',
                icon: 'fa-gear',
                markerColor: 'yellow',
                prefix: 'fa',
                shape: 'star'
            }
        },
            {
                lng: 43.998665,
                lat: 56.288137,
                layer: 'event',
                message: "MeteorJS",
                icon: {
                    type: 'extraMarker',
                    icon: 'fa-calendar',
                    markerColor: 'green',
                    prefix: 'fa'
                }
            },
            {
                lng: 44.006265,
                lat: 56.322584,
                layer: 'event',
                message: "Frontend hackathon",
                icon: {
                    type: 'extraMarker',
                    icon: 'fa-calendar',
                    markerColor: 'green',
                    prefix: 'fa'
                }
            }
        ];

        function formatPlacemarks(events) {
            return events.map(function (placemark) {
                return {
                    lng: placemark.location ? 0 : 44.006265,
                    lat: placemark.location ? 0 : 56.322584,
                    layer: 'event',
                    message: placemark.title,
                    placemarkId: placemark.id,
                    icon: {
                        type: 'extraMarker',
                        icon: 'fa-calendar',
                        markerColor: 'green',
                        prefix: 'fa'
                    }
                };
            })
        }

        return {

            getPlacemarks: function () {

                //return $q.when(STUB);
                return Event.getEvents().then(function(events){return formatPlacemarks(events)});
            },
            getPlacemark: function (id) {
                var url = oneEventUrl.replace('{0}', id);
                return $http.jsonp(url);
            }

        };
    }]);
}());