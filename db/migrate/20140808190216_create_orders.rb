class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.references :address, index: true
      t.decimal :price, precision: 8, scale: 2
      t.boolean :is_purchased
      t.boolean :is_delivered

      t.timestamps
    end
  end
end
