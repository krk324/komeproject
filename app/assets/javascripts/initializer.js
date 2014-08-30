var Hackmai = Hackmai || {};
 Hackmai.initialize = function() {

  Hackmai.CartApp.initializer();

  $('#d1').contenthover({
    overlay_background:'#000',
    overlay_opacity:0.7,
  });
  // $(".animsition").animsition({
  //   inClass               :   'zoom-in',
  //   outClass              :   'zoom-out',
  //   inDuration            :    900,
  //   outDuration           :    800,
  //   linkElement           :   '.animsition-link',
  //   // e.g. linkElement   :   'a:not([target="_blank"]):not([href^=#])'
  //   touchSupport          :    true,
  //   loading               :    true,
  //   loadingParentElement  :   'body', //animsition wrapper element
  //   unSupportCss          : [ 'animation-duration',
  //                             '-webkit-animation-duration',
  //                             '-o-animation-duration'
  //                           ]
  // });

};

