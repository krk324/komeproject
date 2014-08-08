class MenuItem < ActiveRecord::Base
  has_many :carts, dependent: :destroy
  has_many :options, dependent: :destroy
  has_many :toppings, through: :options
  validates :name, presence: true
end
