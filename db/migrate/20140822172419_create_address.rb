class CreateAddress < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.text :street, null: false

      t.timestamps
    end
  end
end
