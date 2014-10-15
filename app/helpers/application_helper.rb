module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in flash-alert") do
               concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
               concat message
      end)
    end
    nil
  end
  # for tip calculation
  def get_order_id
    if current_user.orders.exists?
      current_user_last_order = current_user.orders.last
      current_user_last_order ? current_user_last_order.id : Order.last.id
    end
  end

  def get_user_address_history
    current_user.orders.pluck(:address).uniq.each
  end
end
