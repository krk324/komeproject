class CartsController < ApplicationController
  before_action :set_order, only: [:new, :create]

  def default_serializer_options
    { root: false }
  end

  respond_to :json, :html

  def create
    p = params
    binding.pry
    @cart_item = @order.carts.new(cart_item_params)
    @cart_item.user_id = current_or_guest_user.id

    @cart_item.save!

  end

  def destroy
    @cart_item = Cart.find(params[:id])

  end

  private

  def cart_item_params
    params.require(:cart).permit(:menu_item_id, :quantity)
  end

end
