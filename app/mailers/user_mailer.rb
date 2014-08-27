class UserMailer < ActionMailer::Base
  default from: "info@hackmai.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_welcome_mail.subject
  #
  def send_welcome_mail(user)
    @greeting = "Hi"

    @user = user
    mail(:to => "#{user.username} <#{user.email}>", :subject => "Registered")
  end

  def send_order_confirmation(order)
    @order = order
    mail(:to => "#{user.username} <#{user.email}>", :subject => "Order Confirmation")
  end
end
