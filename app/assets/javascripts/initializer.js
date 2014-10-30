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
      new google.maps.LatLng(41.86020455269385, -87.61239409446716),
      new google.maps.LatLng(41.85892604851976, -87.65633940696716),
      new google.maps.LatLng(41.90340296000016, -87.65977263450623),
      new google.maps.LatLng(41.903658484960495, -87.62217879295349),
      new google.maps.LatLng(41.8971422790361, -87.61651396751404),
      new google.maps.LatLng(41.89343668892004, -87.61393904685974),
      new google.maps.LatLng(41.894075599106294, -87.61136412620544),
      new google.maps.LatLng(41.896375622858514, -87.609304189682),
      new google.maps.LatLng(41.89624784593415, -87.60260939598083),
      new google.maps.LatLng(41.88845297012656, -87.60226607322693),
      new google.maps.LatLng(41.887430620775376, -87.61119246482849),
      new google.maps.LatLng(41.88334105976335, -87.61273741722107),
      new google.maps.LatLng(41.879890289047395, -87.61582732200623),
      new google.maps.LatLng(41.869281197314024, -87.61548399925232),
      new google.maps.LatLng(41.86876987130632, -87.6115357875824),
      new google.maps.LatLng(41.86761937283532, -87.61067748069763),
      new google.maps.LatLng(41.867363703696626, -87.60535597801208),
      new google.maps.LatLng(41.8639120702504, -87.60587096214294),
      new google.maps.LatLng(41.85291673651496, -87.60569930076599),
      new google.maps.LatLng(41.85227741477513, -87.60964751243591),
      new google.maps.LatLng(41.85483466339386, -87.61067748069763),
      new google.maps.LatLng(41.85994885390391, -87.61067748069763),
      new google.maps.LatLng(41.860228524402984, -87.61236190795898)
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

