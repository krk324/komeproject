# == Schema Information
#
# Table name: menu_items
#
#  id          :integer          not null, primary key
#  name        :text             not null
#  image_url   :text
#  price       :decimal(8, 2)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class MenuItem < ActiveRecord::Base
  has_many :carts, dependent: :destroy
  has_many :options, dependent: :destroy
  has_many :toppings, through: :options
  validates :name, presence: true
end
