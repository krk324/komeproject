class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.boolean :is_addon
      t.references :menu_item, index: true
      t.references :topping, index: true

      t.timestamps
    end
  end
end
