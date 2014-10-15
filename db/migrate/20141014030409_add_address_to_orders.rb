class AddAddressToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :address, :string
    add_column :orders, :latitude, :float8
    add_column :orders, :longitude, :float8
  end
end
