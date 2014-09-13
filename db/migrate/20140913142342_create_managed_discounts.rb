class CreateManagedDiscounts < ActiveRecord::Migration
  def change
    create_table :managed_discounts do |t|
      t.belongs_to :user, index: true
      t.belongs_to :discount, index: true
      t.string :is_used

      t.timestamps
    end
  end
end
