# == Schema Information
#
# Table name: menu_items
#
#  id          :integer          not null, primary key
#  name        :text             not null
#  image_url   :text
#  price       :decimal(8, 2)
#  quantity    :integer
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class MenuItem < ActiveRecord::Base
  has_many :carts, dependent: :destroy
  validates :name, presence: true
end
