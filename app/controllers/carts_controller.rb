class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:create]

  def default_serializer_options
    { root: false }
  end

  respond_to :json, :html

  def create

    cart_item_params.each do |item|
      @cart_item = @order.carts.new(item)
      @cart_item.user_id = current_user.id

      @cart_item.save!
    end
    render :json=>'{}', :status => :ok
  end

  private

  def cart_item_params
    params.require(:cart).map do |item|
      params = ActionController::Parameters.new(item.to_hash).permit(:menu_item_id, :quantity)
    end
  end

end
