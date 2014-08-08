class Selection < ActiveRecord::Base
  belongs_to :option
  belongs_to :cart
end
