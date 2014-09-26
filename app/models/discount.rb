# == Schema Information
#
# Table name: discounts
#
#  id             :integer          not null, primary key
#  code           :string(255)
#  discount_value :decimal(, )
#  order_id       :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Discount < ActiveRecord::Base
  has_many :users, through: :ManagedDiscount
  has_many :orders
  has_many :managed_discounts, class_name: 'ManagedDiscount'
  # has many through
  has_many :users, through: :managed_discounts
end
