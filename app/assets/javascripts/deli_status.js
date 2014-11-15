var Hackmai = Hackmai || {};

  Hackmai.deliStatusApp = {

  changeDeliStatus: function(){
    var deliStatus = event.currentTarget.id;
    var orderId = this.parentElement.parentElement.parentElement.childNodes[1].id;
    var that = $(this);
    $.ajax({
        type: "PUT",
        url: '/orders/' + orderId,
        data: { order: { deli_status: deliStatus } },
        dataType: 'json'
    })
    .done(function(data){
      that.parent().next().html("<strong>"+deliStatus+"</strong>");
    });
  },
  initializer: function(event){
    $("[id=deli-statuses]").children().on('click', this.changeDeliStatus);


  }
};

