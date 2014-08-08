class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.references :cart, index: true
      t.references :option, index: true
      t.boolean :is_selected

      t.timestamps
    end
  end
end
