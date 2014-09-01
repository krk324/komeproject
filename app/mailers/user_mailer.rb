class UserMailer < ActionMailer::Base
  include Resque::Mailer
  default from: "info@hackmai.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_welcome_mail.subject
  #
  def send_welcome_mail(user_id)
    @greeting = "Hi"

    @user = User.find(user_id)
    mail(:to => "<#{@user.email}>", :subject => "Registered")
  end

  def send_order_confirmation(order_id,user_id)
    @order = Order.find(order_id)
    @user = User.find(user_id)

    mail(:to => "<#{@user.email}>", :subject => "Welcome to Hackmai <%=@user.email%>.")
  end
end
