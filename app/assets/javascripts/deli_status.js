var Hackmai = Hackmai || {};

  Hackmai.deliStatusApp = {

  changeDeliStatus: function(){
    var deliStatus = event.currentTarget.id;
    var orderId = $('#order-id').text();
    $.ajax({
        type: "PUT",
        url: '/orders/' + orderId,
        data: { order: { deli_status: deliStatus } },
        dataType: 'json'
    })
    .done(function(data){
      $("[id=deli-status]").text('status: '+ deliStatus);
    });
  },
  initializer: function(event){
    $("#deli-statuses").children().on('click', this.changeDeliStatus.bind(this));


  }
};

