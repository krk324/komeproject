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
end
