var CartItem = function(id,quantity,price,name){
    this.menu_item_id = id;
    this.quantity = parseInt(quantity);
    this.price = parseInt(price);
    this.name = name;
  };

  CartItem.prototype = {
    itemTotalAmount: function() {
      Amount  = this.price * this.quantity;
      return Amount;
    },
  };


