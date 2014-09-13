class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.string :code, index: true, unique: true
      t.decimal :discount_value
      t.references :order
      t.timestamps
    end
  end
end
