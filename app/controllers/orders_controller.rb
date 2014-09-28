class OrdersController < ApplicationController
  #before_action :current_or_guest_user
  respond_to :json,:html
  def index
    @menuitems = MenuItem.all.sort
  end

  def update
    @order = current_user.orders.last
    if @order.update(order_params)
      render :json=>'{}', :status => :ok
    end
  end

  def order_params
    params.require(:order).permit(:tip)
  end

end
