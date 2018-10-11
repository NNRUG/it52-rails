'use strict';

angular
    .module('map')
    .controller('MapController', ['$scope', 'Placemark', 'Event', 'EventDetail', function($scope, Placemark,Event, EventDetail){
        var NN = {
            lat: 56.32894042,
            lng: 44.000863,
            zoom: 12
        };
        $scope.center= NN;

        Placemark.getPlacemarks().then(function(placemarks){
            $scope.markers = placemarks;
        });

        $scope.$on("leafletDirectiveMarker.click", function(event, args){
            Event.getEvent(args.model.placemarkId).then(function(event){
                EventDetail.show(event);
            });
        });

        $scope.toggleEvent = function(){
            $scope.layers.overlays.event.visible = !$scope.layers.overlays.event.visible;
        };
        $scope.toggleCompanies = function(){
            $scope.layers.overlays.company.visible = !$scope.layers.overlays.company.visible;
        };

        $scope.layers= {
            baselayers: {
                osm: {
                    name: 'OpenStreetMap',
                    type: 'xyz',
                    url: 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    layerOptions: {
                        subdomains: ['a', 'b', 'c'],
                        continuousWorld: true
                    }
                }
            },
            overlays: {
                company: {
                    name: 'companies',
                    type: 'markercluster',
                    visible: true
                },
                event:{
                    name: 'event',
                    type: 'markercluster',
                    visible: true
                }
            }
        };
    }
    ]);
