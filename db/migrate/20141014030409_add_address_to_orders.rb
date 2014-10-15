class AddAddressToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :address, :string
    add_column :users, :latitude, :float8
    add_column :users, :longitude, :float8
  end
end
