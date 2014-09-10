class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :latitude, :float8
    add_column :users, :longitude, :float8
  end
end
