var Hackmai = Hackmai || {};

  Hackmai.showModalApp = {

  showAboutus: function(){
    $('#aboutModal').modal('show');
  },
  showContact: function(){
    $('#contactModal').modal('show');
  },
  initializer: function(event){
    $('#about-link').on('click', this.showAboutus.bind(this));
    $('#contact-link').on('click', this.showContact.bind(this));
  }
};

