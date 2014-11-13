ActiveAdmin.register Order do
  permit_params :user_id,:deli_status

  batch_action :destroy, :confirm => "Are you sure you want to delete all of these?" do |selection|
    Order.find(selection).each do |order|
      order.destroy
      redirect_to :back
    end
  end
  actions :index, :show, :edit, :update

  filter :user
  filter :updated_at

  scope :all
  scope :not_purchased
  scope :purchased, :default => true

  index do
    selectable_column
    column("Order", :sortable => :id) {|order| link_to "##{order.id} ", admin_order_path(order) }
    column("Date", :updated_at)
    column("Delivery_Status")               {|order| status_tag(order.deli_status)}
    column("Customer", :user, :sortable => :user_id) {|order| order.user.email }
    column("Total")                   {|order| number_to_currency order.price }
    actions
  end

  form do |f|
    f.inputs "Order Details" do
      f.input :deli_status, as: :radio, collection: {Delivered: "delivered", Ontheway: "ontheway", Pending: "pending"}
    end
    f.actions
  end

  show do
    h3 "Delivery Status: " + order.deli_status
    panel "Invoice" do
      table_for(order.carts) do |t|
        t.column("Product") {|item| auto_link item.menu_item}
        t.column("Price") {|item| auto_link item.menu_item.price}
        t.column("Quantity") {|item| auto_link item.quantity}

        tr :class => "odd" do
          td "Total:", :style => "text-align: right;"
          td number_to_currency(order.price)
        end
      end
    end

    active_admin_comments
  end

  sidebar :customer_information, :only => :show do
    attributes_table_for order.user do
      row("User") { auto_link order.user }
      row :email
    end
  end

end
