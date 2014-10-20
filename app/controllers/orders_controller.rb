class OrdersController < ApplicationController
  #before_action :current_or_guest_user
  respond_to :json,:html
  def index
    @menuitems = MenuItem.all.sort
  end

  def show
    @order =  Order.find(params[:id])
    authorize! :read, @order
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      render :json=>'{}', :status => :ok
    end
  end

  def order_params
    params.require(:order).permit(:tip, :deli_status, :latitude, :longitude)
  end

end
