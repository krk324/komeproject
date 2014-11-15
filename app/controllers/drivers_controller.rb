class DriversController < ApplicationController

  def index
    @orders = Order.order('created_at DESC').where(is_purchased: true, created_at: Date.today)
    authorize! :read, @orders
  end

end
