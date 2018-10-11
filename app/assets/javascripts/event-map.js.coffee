# $ ->
#   $('.event-map').each () -> new EventMap(@)

# class EventMap
#   constructor: (@el) ->
#     @$el      = $(@el)
#     @mapId    = @el.id
#     @coords   = @el.dataset.location.split(',')
#     @place    = @el.dataset.place
#     @zoom     = 11
#     @editable = @el.dataset.mapEditable
#     @map = null

#     @handleMapLink() unless @editable

#   renderMap: () ->
#     that = @
#     if that.map == null
#       ymaps.ready ->
#         that.map = new ymaps.Map(that.mapId,
#           center: that.coords
#           zoom: that.zoom
#           controls: [ 'smallMapDefaultSet' ]
#         )
#         that.addPlacemark that.coords, that.place
#     else
#       return

#   handleMapLink: ->
#     that = @
#     $('.event-map-link').on 'click', (e) ->
#       that.renderMap()
#       $("##{that.dataset.target}").toggleClass('visible')
#       e.preventDefault()
#       e.stopPropagation()
#       false



#     # @locationInput = document.getElementById @locationId
#     # @placeInput = document.getElementById @placeId
#     # @locationString = @locationInput.value
#     # @addressString = @locationInput.value
#     # if @locationString.length > 0
#     #   @coords = @locationString.split(',').map Number
#     # else
#     #   @coords = [ 56.326887, 44.005986 ]


#   addPlacemark: (coords, place) =>
#     options = {}
#     options.draggable = true if @editable
#     @placemark = new ymaps.Placemark coords, options
#     @placemark.name = @place
#     @map.geoObjects.removeAll()
#     @map.geoObjects.add @placemark
#     @map.setCenter coords
#     if @editable
#       @placemark.events.add 'dragend', =>
#         locationInput.value = @placemark.geometry.getCoordinates().join(',')

#   debounce: (fn, timeout, ctx) ->
#     timer = undefined
#     ->
#       args = arguments
#       ctx = ctx or this
#       clearTimeout timer
#       timer = setTimeout((->
#         fn.apply ctx, args
#         timer = null
#         return
#       ), timeout)
#       return

#   # $('.event_place').map ->
#   #   $input = $(this).find('input')
#   #   address = undefined
#   #   $map = $(this).next('.event-map')
#   #   locationInput = document.getElementById('event_location')
#   #   locationString = locationInput.value
#   #   if locationString.length > 0
#   #     coords = locationString.split(',').map(Number)
#   #   else
#   #     coords = [ 56.326887, 44.005986 ]
#   #   myMap = undefined
#   #   id = 'm' + Math.random()

#   #   addPlacemark = (coords) ->
#   #     placemark = new (ymaps.Placemark)(coords, {}, draggable: true)
#   #     myMap.geoObjects.removeAll()
#   #     myMap.geoObjects.add placemark
#   #     myMap.setCenter coords
#   #     placemark.events.add 'dragend', ->
#   #       locationInput.value = placemark.geometry.getCoordinates().join(',')

#   #   $map.attr 'id', id
#   #   ymaps.ready ->
#   #     myMap = new (ymaps.Map)(id,
#   #       center: coords
#   #       zoom: 11
#   #       controls: [ 'smallMapDefaultSet' ])
#   #     coords.length and addPlacemark(coords)
#   #     return
#   #   $input.on 'change keyup paste', debounce((->
#   #     address = $input.val()
#   #     ymaps.geocode(address,
#   #       kind: 'house'
#   #       results: 1).then (res) ->
#   #         `var coords`
#   #         coords = res.geoObjects.get(0).geometry.getCoordinates()
#   #         addPlacemark coords
#   #         locationInput.value = coords.join(',')
#   #         return
#   #       return
#   #   ), 300)
#   #   return
#   # $('.event-place').map ->
#   #   $link = $(this).find('a')
#   #   address = $link.html()
#   #   coords = ($link.attr('data-location') or '').split(',').map(Number)
#   #   $map = $(this).find('.event-map')

#   #   init = ($map) ->
#   #     id = 'm' + Math.random()
#   #     $map.attr 'id', id
#   #     myMap = new (ymaps.Map)(id,
#   #       center: coords
#   #       zoom: 9
#   #       controls: [ 'smallMapDefaultSet' ])
#   #     if coords
#   #       myMap.geoObjects.add new (ymaps.Placemark)(coords, { balloonContent: address }, preset: 'islands#icon')
#   #     else
#   #       ymaps.geocode(address,
#   #         kind: 'house'
#   #         results: 1).then (res) ->
#   #         `var coords`
#   #         firstGeoObject = res.geoObjects.get(0)
#   #         coords = firstGeoObject.geometry.getCoordinates()
#   #         bounds = firstGeoObject.properties.get('boundedBy')
#   #         myMap.geoObjects.add firstGeoObject
#   #         myMap.setBounds bounds, checkZoomRange: true
#   #         return
#   #     $map.inited = true
#   #     return

#   #   coords.length == 2 and coords[0] and coords[1] or (coords = null)

#   #   $link.click (e) ->
#   #     $map.toggleClass 'visible'
#   #     $map.inited or init($map)
#   #     false
#   #   return
#   # return
