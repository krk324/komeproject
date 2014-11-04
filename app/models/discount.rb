# == Schema Information
#
# Table name: discounts
#
#  id             :integer          not null, primary key
#  code           :string(255)
#  discount_value :decimal(, )
#  created_at     :datetime
#  updated_at     :datetime
#

class Discount < ActiveRecord::Base
  belongs_to :order
end
