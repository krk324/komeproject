var Hackmai = Hackmai || {};

  var CartItems = CartItems || [];
  Hackmai.CartApp = {

  addItem: function(event){
    var Id = event.currentTarget.getAttribute('data-id');
    var quantity = parseInt(event.currentTarget.parentElement.nextElementSibling.textContent);

    var flag = 0;
    for (var i = CartItems.length - 1; i >= 0; i--) {
      if (CartItems[i].menu_item_id === Id) {
        CartItems[i].quantity += 1;
        flag = 1;
      }
    }

    if (flag === 0) {
      var newCartItem = new CartItem(Id,1);
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

      var flag = 0;
      for (var i = CartItems.length - 1; i >= 0; i--) {
        if (CartItems[i].menu_item_id === Id) {
          CartItems[i].quantity -= 1;
          flag = 1;
        }
      }

      if (flag === 0) {
        var newCartItem = new CartItem(Id,0);
        CartItems.push(newCartItem);
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
    .done(window.location.href = "/carts/new");
    event.preventDefault();
  },
  showOrder: function() {
    var theData = {customers:[{firstName:"Michael", lastName:"Alexander", age:20}, {firstName:"John", lastName:"Allen", age:29}]};
    $('.modal-body').empty();
    $(HandlebarsTemplates.orderForm({cart:CartItems})).appendTo('.modal-body');
    $('html, body').animate({ scrollTop: 0 }, 0);

  },
  initializer: function(event){
     $('[id="delete-button"]').on('click', this.deleteItem);
     $('[id="add-button"]').on('click', this.addItem);
     $('#checkout').on('click', this.showOrder.bind(this));



  }
};

