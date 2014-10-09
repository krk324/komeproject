class DriversController < ApplicationController

  def index
    @orders = Order.all
    authorize! :read, @orders
  end

end
