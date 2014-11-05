var CartItem = function(id,quantity,price,name){
    this.menu_item_id = id;
    this.quantity = parseInt(quantity);
    this.price = parseFloat(price).toFixed(2);
    this.name = name;
  };

  CartItem.prototype = {
    itemTotalAmount: function() {
      Amount  = this.price * this.quantity;
      return Amount;
    },
  };


