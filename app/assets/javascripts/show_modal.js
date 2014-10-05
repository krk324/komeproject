var Hackmai = Hackmai || {};

  Hackmai.showModalApp = {

  showAboutus: function(){
    $('#aboutModal').modal('show');
  },
  showContact: function(){
    $('#contactModal').modal('show');
  },
  showPrivacy: function(){
    $('#privacyModal').modal('show');
  },
  showTerms: function(){
    $('#termsModal').modal('show');
  },
  showMap: function(){
    $('#mapModal').modal('show');
  },
  initializer: function(event){
    $('#about-link').on('click', this.showAboutus.bind(this));
    $('#contact-link').on('click', this.showContact.bind(this));
    $('#privacy-link').on('click', this.showPrivacy.bind(this));
    $('#terms-link').on('click', this.showTerms.bind(this));
    $('#map-link').on('click', this.showMap.bind(this));

  }
};

