var Hackmai = Hackmai || {};
 Hackmai.initialize = function() {

  Hackmai.CartApp.initializer();
  Hackmai.showModalApp.initializer();
  //Flash alert slideup
  $(function() {
    setTimeout(function(){
      $('.flash-alert').slideUp(700);
    }, 50000);
  });

  //google map delivery area
  function initialize() {
    var chicago = new google.maps.LatLng(41.875696,-87.624207);
    var mapOptions = {
      zoom: 30,
      center: chicago
    };

    var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

    var ctaLayer = new google.maps.KmlLayer({
      url: 'https://s3-us-west-2.amazonaws.com/hackmai/03102014-4z87fde9.kml'
    });
    ctaLayer.setMap(map);
  }

  google.maps.event.addDomListener(window, 'load', initialize);

};

