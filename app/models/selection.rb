# == Schema Information
#
# Table name: selections
#
#  id          :integer          not null, primary key
#  cart_id     :integer
#  option_id   :integer
#  is_selected :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

class Selection < ActiveRecord::Base
  belongs_to :option
  belongs_to :cart
end
