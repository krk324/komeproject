class CreateToppings < ActiveRecord::Migration
  def change
    create_table :toppings do |t|
      t.text :name, null: false
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
