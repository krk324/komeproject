var Hackmai = Hackmai || {};
 Hackmai.initialize = function() {

  Hackmai.CartApp.initializer();

  window.currentUser = {
      id : "<%=current_user.id%>"
  };

};

