# == Schema Information
#
# Table name: options
#
#  id           :integer          not null, primary key
#  is_addon     :boolean
#  menu_item_id :integer
#  topping_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Option < ActiveRecord::Base
  belongs_to :menu_item
  belongs_to :topping
  has_many :selections, dependent: :destroy
  has_many :carts, through: :selections
end
