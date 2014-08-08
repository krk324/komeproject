class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :neighborhood
  has_many :order_items, dependent: :destroy
end
