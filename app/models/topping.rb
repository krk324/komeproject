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
  has_many :options, dependent: :destroy
  has_many :menu_items, through: :options
  validates :name, presence: true
end
