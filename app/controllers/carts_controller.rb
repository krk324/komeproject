class CartsController < ApplicationController
  before_action :set_order, only: [:new, :create]

  def default_serializer_options
    { root: false }
  end

  respond_to :json, :html

  def create
    items = []

    cart_item_params.each do |item|
      @cart_item = @order.carts.new(item)
      @cart_item.user_id = current_or_guest_user.id
      items << @cart_item if @cart_item.save!
      respond_with(@cart_item)
    end

  end

  def destroy
    @cart_item = Cart.find(params[:id])

  end

  private

  def cart_item_params
    params.require(:cart).map do |item|
      ActionController::Parameters.new(item.to_hash).permit(:menu_item_id, :quantity)
    end
  end

end
