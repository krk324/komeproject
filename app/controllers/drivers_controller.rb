class DriversController < ApplicationController

  def index
    @orders = Order.order('created_at DESC').all
    authorize! :read, @orders
  end

end
