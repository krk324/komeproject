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

};

