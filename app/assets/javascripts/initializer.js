var Hackmai = Hackmai || {};
 Hackmai.initialize = function() {

  Hackmai.CartApp.initializer();
  Hackmai.showModalApp.initializer();
  Hackmai.deliStatusApp.initializer();

  //Flash alert slideup
  $(function() {
    setTimeout(function(){
      $('.flash-alert').slideUp(700);
    }, 50000);
  });

  //google map delivery area
  function initialize() {
    var chicago = new google.maps.LatLng(41.875696,-87.624207);

    var map = new google.maps.Map(document.getElementById('map-canvas'));

    var polyCoordinates = [
      new google.maps.LatLng(41.890777,-87.644420),
      new google.maps.LatLng(41.889212,-87.614422),
      new google.maps.LatLng(41.883940,-87.615066),
      new google.maps.LatLng(41.881480,-87.617855),
      new google.maps.LatLng(41.867484,-87.619143),
      new google.maps.LatLng(41.861187,-87.618542),
      new google.maps.LatLng(41.849169,-87.613778),
      new google.maps.LatLng(41.848401,-87.617555),
      new google.maps.LatLng(41.847922,-87.641501),
      new google.maps.LatLng(41.850064,-87.644205)
    ];
    var polyOptions = {
      path: polyCoordinates,
      strokeColor: "#FF0000",
      strokeOpacity: 0.8,
      strokeWeight: 2,
      fillColor: "#FF0000",
      fillOpacity: 0.3
    };
    var it = new google.maps.Polygon(polyOptions);
    it.setMap(map);

    $("#mapModal").on("shown.bs.modal", function(e) {
      google.maps.event.trigger(map, "resize");
      map.setCenter(chicago);
      map.setZoom(14);
  });
  }

  google.maps.event.addDomListener(window, 'load', initialize);

};

