var Hackmai = Hackmai || {};

  var CartItems = CartItems || [];
  var initAddress = "";
  var initPhone = "";

  //geocoding delivery boundary
  var geocoder = new google.maps.Geocoder();
  var polyCordinates = [
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
  var deliveryArea = new google.maps.Polygon({paths: polyCordinates});
  var flag2 = 0; //flag for address check.
  var latitude = 0;
  var longitude = 0;

  Hackmai.CartApp = {

  addItem: function(event){
    var Id = event.currentTarget.getAttribute('data-id');
    var quantity = parseInt(event.currentTarget.parentElement.nextElementSibling.textContent);
    var price = event.currentTarget.getAttribute('data-price');
    var name = event.currentTarget.getAttribute('data-name');

    var flag = 0;
    for (var i = CartItems.length - 1; i >= 0; i--) {
      if (CartItems[i].menu_item_id === Id) {
        CartItems[i].quantity += 1;
        flag = 1;
      }
    }

    if (flag === 0) {
      var newCartItem = new CartItem(Id,1,price,name);
      CartItems.push(newCartItem);
    }

    quantity += 1;
    $(event.currentTarget.parentElement.nextElementSibling).text(quantity);

    //enable button when clicked
    $('#checkout').prop('disabled', false);
    event.preventDefault();
  },
  deleteItem: function(event){
    var Id = event.currentTarget.getAttribute('data-id');
    var quantity = parseInt(event.currentTarget.parentElement.nextElementSibling.textContent);

    if ( quantity > 0){

      for (var i = CartItems.length - 1; i >= 0; i--) {
        if (CartItems[i].menu_item_id === Id) {
          CartItems[i].quantity -= 1;

          if (CartItems[i].quantity === 0){
            //fix problem where wrong array get spliced.
            var index = CartItems.indexOf(CartItems[i]);
            CartItems.splice(index, 1);
          }
        }
      }

      quantity -= 1;
      if (CartItems.length === 0){
        $('#checkout').prop('disabled', true);
      }
      $(event.currentTarget.parentElement.nextElementSibling).text(quantity);
    }

    event.preventDefault();
  },
  createCart: function(){
      $.ajax({
        type: "POST",
        url: '/carts',
        data:    JSON.stringify({cart: CartItems}),
        contentType: 'application/json',
        dataType: 'json'
      });
  },
  updateUserInfo: function(address,phone,latitude,longitude){
      if (initAddress !== address) {
        $.ajax({
          type: "PUT",
          url: '/users',
          data: { user: { address: address } },
          dataType: 'json'
        });
        $.ajax({
          type: "PUT",
          url: '/users',
          data: { user: { latitude: latitude } },
          dataType: 'json'
        });
        $.ajax({
          type: "PUT",
          url: '/users',
          data: { user: { longitude: longitude } },
          dataType: 'json'
        });
      }
      if (initPhone !== phone) {
        $.ajax({
          type: "PUT",
          url: '/users',
          data: { user: { phone: phone } },
          dataType: 'json'
        });
      }
  },
  fillAddressText: function(event){
    $('#address').val(event.currentTarget.text);
  },
  evalInputs: function() {

    //check if logout link exist in the navbar.(check if user is logged in)
    if ($('.navbar-dropdown li a').last().attr('data-method') !== 'delete'){
      window.location.href = "/users/sign_up";
      return;
    }

    if ($('#address').val() === "" || $('#phone-input').val() === "(   )    -    " ){
      //scroll to the top of the page.
      window.scroll(0,0);
      //alert under searchbox.
      alertify.error("Oops! Please enter your delivery address and phone number.");

      //prevent modal showing up.
      $('#checkout').removeAttr("data-toggle");
    }
    else {
      // if user input address is unknown or out of area it will pop-up error.
      // showCheckout function is inside this function.
      this.checkAddress();
    }

  },
  checkAddress: function(){
    //get user address.
    var address = $('#address').val();
    //prevent modal from showing up.
    $('#checkout').removeAttr("data-toggle");

    geocoder.geocode( { 'address': address }, function(results, status) {
      flag2 = 0;
      if (status == google.maps.GeocoderStatus.OK) {
        if (!google.maps.geometry.poly.containsLocation(results[0].geometry.location, deliveryArea)){
          flag2 = 1;
          alertify.error("We currently don't delivery to your area.");
        }
      }
      else {
        alertify.error('Please enter valid address-' + status);
        flag2 = 1;
      }
      //set coordinates
      latitude = results[0].geometry.location.k;
      longitude = results[0].geometry.location.B;
      Hackmai.CartApp.showCheckout();
    });
  },
  showCheckout : function(){
    // if input address is not valid or out of bound it will end the function.
    if (flag2 === 1){
      return;
    }

    $("#alert-address").remove();

    //Calculate total
    CartItems.total = 0;
    for (var i = CartItems.length - 1; i >= 0; i--) {
      CartItems.total = CartItems.total + (CartItems[i].price * CartItems[i].quantity);
    }
    $('.modal-body').empty();
    $(HandlebarsTemplates.orderForm({cart:CartItems})).appendTo('.modal-body');
    $('html, body').animate({ scrollTop: 0 }, 0);

    //add address and phonenumber to the order confirmation pop-up.
    var address = $('#address').val();
    $('#address-confirm').after("<p>"+address+"</p>");
    var phone = $('#phone-input').val();
    $('#phone-confirm').after("<p>"+phone+"</p>");

    //add items to the Cart.
    this.createCart();

    //add address to user
    this.updateUserInfo(address,phone,latitude,longitude);

    //show the checkout modal.
    $('#checkoutModal').modal('show');

    //hide spinner image.
    $('.image-loader-overlay').hide();
  },
  initializer: function(event){
    $('[id="delete-button"]').on('click', this.deleteItem.bind(this));
    $('[id="add-button"]').on('click', this.addItem.bind(this));
    $('#checkout').on('click', this.evalInputs.bind(this));
    $('[id="user-address"]').on('click', this.fillAddressText.bind(this));

    //apply phoneinput format to the hadlebar templates.
    $('#phone-input').formatter({
      'pattern': '({{999}}) {{999}}-{{9999}}',
      'persistent': true
    });

    //set initial address and phone number.
    initAddress = $('#address').val();
    initPhone = $('#phone-input').val();

    //Refresh page and then redirect to the orderpage.
    //clear the javascript array.
    $('[id="order-link"]').click(function() {
      location.reload();
      window.location.href = "/orders";
    });
  }
};

