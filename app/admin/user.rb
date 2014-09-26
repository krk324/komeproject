ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :role
    actions
  end

  filter :email

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role, as: :radio, collection: {Customer: "customer", Driver: "Driver", Administrator: "administrator"}
    end
    f.actions
  end
end
