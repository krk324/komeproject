class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.decimal :price, precision: 8, scale: 2
      t.references :menu_item, index: true
      t.references :order, index: true
      t.integer :qunatity

      t.timestamps
    end
  end
end
