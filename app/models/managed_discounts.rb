class ManagedDiscounts < ActiveRecord::Base
  belongs_to :user
  belongs_to :discount
end
