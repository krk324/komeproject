class CartsController < ApplicationController
  before_action :set_order, only: [:new, :create]

  def default_serializer_options
    { root: false }
  end

  respond_to :json, :html

  def new
    @order_item = OrderItem.new

    respond_with(@order_item)
  end

  def create
    @order_item = @order.order_items.new(order_item_params)

    if @order_item.save!
      respond_with(@order_item)
    end
  end

  def edit
    @order_item = OrderItem.find(params[:id])
    respond_with(@order_item)
  end

  def update
    @order_item = OrderItem.find(params[:id])

    if @order_item.save!
      respond_with(@order_item)
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])

    redirect_to order, alert: "You have removed the item."
  end

  private

  def order_item_params
    params.require(:order_item).permit(:menu_item_id, :quantity, selections_attributes: [:option_id, :is_selected])
  end

end
