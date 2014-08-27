class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @order = current_user.orders.last
    @amount = (@order.total_amount*100).to_i

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    @order.is_purchased = true
    @order.save
    UserMailer.send_order_confirmation(@order,current_user).deliver

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
