var Hackmai = Hackmai || {};

  Hackmai.CartApp = {

  addItem: function(event){
    var Id = event.currentTarget.getAttribute('data-id');
    var quantity = parseInt(event.currentTarget.parentElement.nextElementSibling.textContent);
    quantity += 1;
    $(event.currentTarget.parentElement.nextElementSibling).text(quantity);

    event.preventDefault();
  },
  deleteItem: function(event){
    var Id = event.currentTarget.getAttribute('data-id');
    var quantity = parseInt(event.currentTarget.parentElement.nextElementSibling.textContent);
    quantity -= 1;
    $(event.currentTarget.parentElement.nextElementSibling).text(quantity);

    event.preventDefault();
  },
  initializer: function(event){
     $('[id="delete-button"]').on('click', this.deleteItem);
     $('[id="add-button"]').on('click', this.addItem);



  }
};

