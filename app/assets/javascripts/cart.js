var Hackmai = Hackmai || {};

  var CartItems = CartItems || [];

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
      $(event.currentTarget.parentElement.nextElementSibling).text(quantity);
    }

    event.preventDefault();
  },
  createCart: function(event){
      $.ajax({
        type: "POST",
        url: '/carts',
        data:    JSON.stringify({cart: CartItems}),
        contentType: 'application/json',
        dataType: 'json'
      })
    .done();
    event.preventDefault();
  },
  showOrder: function() {
    //Calculate total
    CartItems.total = 0;
    for (var i = CartItems.length - 1; i >= 0; i--) {
      CartItems.total = CartItems.total + (CartItems[i].price * CartItems[i].quantity);
    }
    $('.modal-body').empty();
    $(HandlebarsTemplates.orderForm({cart:CartItems})).appendTo('.modal-body');
    $('html, body').animate({ scrollTop: 0 }, 0);

  },
  initializer: function(event){
     $('[id="delete-button"]').on('click', this.deleteItem.bind(this));
     $('[id="add-button"]').on('click', this.addItem.bind(this));
     $('#checkout').on('click', this.showOrder.bind(this));
     $('.stripe-button-el').on('click', this.createCart.bind(this));


  }
};

