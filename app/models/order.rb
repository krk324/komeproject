# == Schema Information
#
# Table name: orders
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  address_id   :integer
#  price        :decimal(8, 2)
#  tip          :decimal(8, 2)    default(1.0)
#  is_purchased :boolean
#  deli_status  :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Order < ActiveRecord::Base
  belongs_to :user
  has_many :carts, dependent: :destroy
  has_many :discounts

  scope :purchased, -> {where("orders.is_purchased IS TRUE")}
  scope :not_purchased, -> {where("orders.is_purchased IS FALSE")}

  def total_amount
    binding.pry
    total_amount = self.carts.map{|item| item.menu_item.price * item.quantity}.reduce{|sum,price| sum + price}
    total_amount * self.tip
  end
end
