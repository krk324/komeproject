class OrdersController < ApplicationController
  #before_action :current_or_guest_user
  respond_to :json,:html
  def index
    @menuitems = MenuItem.all.sort
  end

  def update
    @order = current_user.orders.last
    @order.update(order_params)
    respond_with(@order)
  end

  # def update
  # @book = Book.find(params[:id])
  # if @book.update(book_params)
  #   redirect_to(@book)
  # else
  #   render "edit"
  # end

  def order_params
    params.require(:order).permit(:tip)
  end

end
