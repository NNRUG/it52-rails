'use strict';

angular
    .module('calendar')
    .controller('CalendarController', ['$scope', 'Event','EventDetail', function ($scope, Event, EventDetail) {
        var now = new Date();
        $scope.year = now.getFullYear();
        $scope.month = now.getMonth();
        $scope.start = getStart($scope.year, $scope.month);
        $scope.events = [];
        $scope.weeks = [[]];
        Event.getEvents().then(function (events) {
            $scope.events = events;
            $scope.weeks = setCalendarModel($scope.year, $scope.month, $scope.events);
            $scope.start = getStart($scope.year, $scope.month);
        });

        $scope.next = function () {
            $scope.year = $scope.month == 12 ? $scope.year + 1 : $scope.year;
            $scope.month = $scope.month == 12 ? 1 : this.month + 1;
            $scope.weeks = setCalendarModel($scope.year, $scope.month, $scope.events);
            $scope.start = getStart($scope.year, $scope.month);
        };
        $scope.prev = function () {
            $scope.year = $scope.month == 1 ? $scope.year - 1 : $scope.year;
            $scope.month = $scope.month == 1 ? 12 : this.month - 1;
            $scope.weeks = setCalendarModel($scope.year, $scope.month, $scope.events);
            $scope.start = getStart($scope.year, $scope.month);
        };
        $scope.onEventClick = function(event){
            EventDetail.show(event);
        };

        $scope.weeks = setCalendarModel($scope.year, $scope.month, $scope.events);

        function setCalendarModel(year, month, allEvents) {

            var start = getStart(year, month);
            var weeks = [[]];

            var week = 0,
                first = getFirstDayOfCalendar(start),
                _i = first.getDate() == 1 && getNumDays(year, month) == 28 ? 28 : 35,
                offset = first.getTimezoneOffset() * -60000;

            for (var i = 0; i < _i; i++) {

                var add = (i * 86400000) + offset;
                var date = new Date(first.valueOf() + add);

                // Sunday? Let's start a new week.
                if (!date.getDay() && weeks[0].length) {
                    week++;
                    weeks.push([]);
                }
                var events = allEvents.reduce(function (acc, event) {
                        var eventDate = new Date(event.started_at);
                        if (compareDates(eventDate, date)) {
                            acc.push(event);
                        }
                        return acc;
                    }, []);
                weeks[week].push({
                    date: date,
                    events: events
                });
            }
            return weeks;
        }

        function getFirstDayOfCalendar(date) {
            var first = new Date(date);
            first.setDate(1 - first.getDay());
            return first;
        }

        function getNumDays(year, month) {
            return new Date(year, month + 1, 0).getDate();
        }

        function getStart(year, month) {
            return new Date(year, month, 1, 0, 0);
        }

        function compareDates(d1, d2) {
            var cd1 = new Date(d1.getFullYear(), d1.getMonth(), d1.getDate());
            var cd2 = new Date(d2.getFullYear(), d2.getMonth(), d2.getDate());
            return cd1.getTime() == cd2.getTime();
        }
    }
    ]);
