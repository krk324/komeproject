# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  street     :text             not null
#  created_at :datetime
#  updated_at :datetime
#

class Address < ActiveRecord::Base
  has_many :orders, dependent: :destroy
end
