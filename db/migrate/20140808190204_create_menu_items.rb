class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.text :name, null:false
      t.text :image_url
      t.decimal :price, precision: 8, scale:2
      t.integer :quantity
      t.text :description

      t.timestamps
    end
  end
end
