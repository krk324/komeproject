class OrdersController < ApplicationController
  before_action :current_or_guest_user

  def index
    @menuitems = MenuItem.all
  end

end
