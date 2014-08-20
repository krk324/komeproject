# == Schema Information
#
# Table name: orders
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  price        :decimal(8, 2)
#  is_purchased :boolean
#

class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :neighborhood
  has_many :carts, dependent: :destroy

  def total_amount
    self.carts.map{|item| item.menu_item.price * item.quantity}.reduce{|sum,price| sum + price}
  end
end
