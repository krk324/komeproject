class ChargesController < ApplicationController
  def new
  end

  def create
    @order = current_user.orders.last

    #check inventory before
    if @order.quantity_calculation
      redirect_to orders_path,
        :flash => { :error => "We're sorry one or more of your items ordered is out of stock. Please reorder from the order page." }
    end


    total_amount = @order.total_amount
    # Amount in cents
    @amount = (total_amount*100).to_i

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Hackmai Stripe customer',
      :currency    => 'usd'
    )

    @order.price = total_amount
    @order.is_purchased = true
    @order.save!
    UserMailer.send_order_confirmation(@order.id,current_user.id).deliver

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
