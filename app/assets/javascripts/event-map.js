$(function() {

$('.event-place').map(function() {
    var $link = $(this).find('a'),
        //address = $link.html(),
        address = 'Нижний Новгород, ул. Алексеевская, 10/16, БЦ Лобачевский Плаза, офис Яндекса',
        $map = $(this).find('.event-map');

    $link.click(function(e) {
        $map.toggleClass('visible');
        init($map);
        return false;
    });

    function init($map) {
        var id = 'm' + Math.random();
        $map.attr('id', id);

        var myMap = new ymaps.Map(id, {
                center: [56.326887, 44.005986],
                zoom: 9
            });

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
});

});
