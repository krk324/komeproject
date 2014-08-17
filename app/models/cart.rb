# == Schema Information
#
# Table name: carts
#
#  id           :integer          not null, primary key
#  price        :decimal(8, 2)
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
  has_many :selections, dependent: :destroy
  has_many :options, through: :selections
  accepts_nested_attributes_for :selections
end
