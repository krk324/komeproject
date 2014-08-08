class Option < ActiveRecord::Base
  belongs_to :menu_item
  belongs_to :topping
  has_many :selections, dependent: :destroy
  has_many :carts, through: :selections
end
