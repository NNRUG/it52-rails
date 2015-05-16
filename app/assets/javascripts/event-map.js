$(function() {

$('.event-place').map(function() {
    var $link = $(this).find('a'),
        address = $link.html(),
        coords = ($link.attr('data-coords') || '').split(',').map(Number),
        $map = $(this).find('.event-map');

    coords.length === 2 && coords[0] && coords[1] || (coords = null);

    $link.click(function(e) {
        $map.toggleClass('visible');
        $map.inited || init($map);
        return false;
    });

    function init($map) {
        var id = 'm' + Math.random();
        $map.attr('id', id);

        var myMap = new ymaps.Map(id, {
                center: coords || [56.326887, 44.005986], // координаты центра НиНо
                zoom: 9,
                controls: ['smallMapDefaultSet']
            });

        if (coords) {
            myMap.geoObjects.add(
                new ymaps.Placemark(
                        coords,
                        { balloonContent: address },
                        { preset: 'islands#icon' }
                    ));
        } else {
            ymaps.geocode(address, {
                kind: 'house',
                boundedBy: myMap.getBounds(),
                strictBounds: true,
                results: 1
            }).then(function(res) {
                var firstGeoObject = res.geoObjects.get(0),
                    coords = firstGeoObject.geometry.getCoordinates(),
                    bounds = firstGeoObject.properties.get('boundedBy');

                myMap.geoObjects.add(firstGeoObject);
                myMap.setBounds(bounds, { checkZoomRange: true });
            });
        }

        $map.inited = true;
    }
});

});
