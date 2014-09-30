class AddQuantityToMenuItems < ActiveRecord::Migration
  def change
    add_column :menu_items, :quantity, :integer
  end
end
