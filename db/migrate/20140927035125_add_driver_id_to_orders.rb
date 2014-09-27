class AddDriverIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :driver_id, :integer
  end
end
