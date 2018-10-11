/*
*  Starting point of your app
*/
(function(){
'use strict';

  angular
      .module('it52.info', ['ngMaterial', 'ui.router','leaflet-directive','ng-mfb', 'btford.markdown', 'map', 'menu', 'calendar','eventDetail'])
      .config( function($mdThemingProvider, $mdIconProvider, $stateProvider, $urlRouterProvider) {

          $mdIconProvider
              .defaultIconSet("assets/svg/avatars.svg", 128 )
              .icon("menu", "assets/svg/ic_menu_24px.svg", 24);


          // Use the 'brown' theme - override default 'blue' theme
          $mdThemingProvider.theme('default')
              .primaryPalette('blue-grey')
              .accentPalette('grey');

          $urlRouterProvider.otherwise('/');

          $stateProvider

               .state('map', {

                  templateUrl: 'src/map/map.html',
                  controller: 'MapController'
              })
              .state('calendar', {
                  url:'/',
                  templateUrl: 'src/calendar/calendar.html',
                  controller: 'CalendarController'
              })
              .state('home', {
                  templateUrl: 'src/home/home.html'
              });

      });

})();
