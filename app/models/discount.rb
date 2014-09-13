class Discount < ActiveRecord::Base
  has_many :users, through: :ManagedDiscount
  has_many :orders
  has_many :managed_discounts, class_name: 'ManagedDiscount'
  # has many through
  has_many :users, through: :managed_discounts
end
