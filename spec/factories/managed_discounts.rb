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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :managed_discount, :class => 'ManagedDiscounts' do
    user nil
    discount nil
    is_used "MyString"
  end
end
