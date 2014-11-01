class HomeController < ApplicationController
  #before_action :current_or_guest_user
  before_action :check_login


  def index
  end

  private

  def check_login
    if user_signed_in?
      redirect_to orders_path if current_user.role == 'customer'
      redirect_to drivers_path if current_user.role =='driver'
      redirect_to admin_root_path if current_user.role == 'administrator'
    end
  end
end
