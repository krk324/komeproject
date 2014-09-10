var Hackmai = Hackmai || {};
 Hackmai.initialize = function() {

  Hackmai.CartApp.initializer();

  //ideal-image-slider plugin.
  var slider = new IdealImageSlider.Slider({
    selector: '#slider', //スライダーのclass
    height: 400, // スライダーの高さ
    interval: 4000, //次のスライドを表示する間隔
    transitionDuration: 700, //アニメーションの時間
    effect: 'slide'
  });
  slider.start();
};

