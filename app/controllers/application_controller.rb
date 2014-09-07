class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  #helper_method :current_or_guest_user

  def after_sign_in_path_for(resource_or_scope)
    orders_path
  end

  protected

  # add username to devise standard setup
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :address, :phone) }
  end

  private

  def set_order
    @order = Order.create(user_id: current_user.id, price: 0, is_purchased: false)
  end
end
