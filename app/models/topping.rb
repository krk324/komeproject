# == Schema Information
#
# Table name: toppings
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  price      :decimal(8, 2)
#  created_at :datetime
#  updated_at :datetime
#

class Topping < ActiveRecord::Base
  has_many :carts, dependent: :destroy
  validates :name, presence: true
end
