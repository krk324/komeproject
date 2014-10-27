var Hackmai = Hackmai || {};

  var CartItems = CartItems || [];
  var initAddress = "";
  var initPhone = "";

  //geocoding delivery boundary
  var geocoder = new google.maps.Geocoder();
  var polyCordinates = [
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

