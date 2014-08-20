class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.references :menu_item, index: true
      t.references :order, index: true
      t.integer :quantity
      t.references :user, index: true

      t.timestamps
    end
  end
end
