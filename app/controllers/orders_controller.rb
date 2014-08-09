class OrdersController < ApplicationController
  def index
    @menuitems = MenuItem.all
  end

  def new
  end
end
