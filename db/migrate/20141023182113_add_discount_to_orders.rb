class AddDiscountToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :discount, index: true
  end
end
