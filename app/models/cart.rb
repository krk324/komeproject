# == Schema Information
#
# Table name: carts
#
#  id           :integer          not null, primary key
#  menu_item_id :integer
#  order_id     :integer
#  quantity     :integer
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Cart < ActiveRecord::Base
  belongs_to :menu_item
  belongs_to :user
  belongs_to :order
  belongs_to :toppings
end
