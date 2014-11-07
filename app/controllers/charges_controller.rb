class ChargesController < ApplicationController
  def new
  end

  def create
    @order = current_user.orders.last

    # check inventory before checkout
    if !@order.quantity_calculation
      redirect_to orders_path
      raise "We're sorry one or more of your items ordered
          is out of stock. Please order again from the order page. *Payment has not been processed."
      UserMailer.send_order_error(@order.id,current_user.id).deliver!
      return
    end

    # Set total_amount and convert to cents
    total_amount = @order.total_amount
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
    # set all values to order
    @order.price = total_amount
    @order.address = current_user.address
    @order.latitude = current_user.latitude
    @order.longitude = current_user.longitude
    @order.is_purchased = true
    @order.save!

    # Send order confirmation
    UserMailer.send_order_confirmation(@order.id,current_user.id).deliver!

    # Go check drivers location
    #Pusher['driver_channel'].trigger('my_event', {})

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  rescue => e
    flash[:error] = e.message
  end

end
