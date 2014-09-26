# == Schema Information
#
# Table name: managed_discounts
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  discount_id :integer
#  is_used     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class ManagedDiscount < ActiveRecord::Base
  belongs_to :user
  belongs_to :discount
end
