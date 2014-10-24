class DriversController < ApplicationController

  def index
    @orders = Order.where(is_purchased: true).sort_by &:created_at
    authorize! :read, @orders
  end

end
