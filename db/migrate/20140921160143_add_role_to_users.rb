class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: 'customer'

    User.create! do |u|
      u.email = "hackmaino1@example.com"
      u.password = "NS8Qv3b62SB8NTv5"
      u.role = "administrator"
      u.username="admin"
    end
  end
end
