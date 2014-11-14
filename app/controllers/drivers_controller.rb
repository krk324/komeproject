class DriversController < ApplicationController

  def index
    @orders = Order.order('created_at DESC').where(is_purchased: true)
    authorize! :read, @orders
  end

end
