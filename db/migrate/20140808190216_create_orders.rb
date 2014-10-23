class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.decimal :price, precision: 8, scale: 2
      t.decimal :tip, precision:8, scale: 2, default: 1
      t.boolean :is_purchased
      t.string :deli_status, default: 'pending'
      references :discount

      t.timestamps
    end
  end
end
