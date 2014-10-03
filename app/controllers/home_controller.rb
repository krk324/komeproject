class HomeController < ApplicationController
  #before_action :current_or_guest_user
  before_action :check_login


  def index
  end

  private

  def check_login
    redirect_to orders_path if current_user
  end
end
