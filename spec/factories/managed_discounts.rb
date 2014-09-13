# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :managed_discount, :class => 'ManagedDiscounts' do
    user nil
    discount nil
    is_used "MyString"
  end
end
