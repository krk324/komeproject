ActiveAdmin.register Order do
  batch_action :destroy, :confirm => "Are you sure you want to delete all of these?" do |selection|
    Order.find(selection).each do |order|
      order.destroy
      redirect_to :back
    end
  end
  actions :index, :show

  filter :user
  filter :updated_at

  scope :all
  scope :not_purchased
  scope :purchased, :default => true

  form do |f|
    f.inputs 'Details' do
      f.input :is_delivered
    end
    f.inputs 'Content', :body
    f.actions
  end

  index do
    selectable_column
    column("Order", :sortable => :id) {|order| link_to "##{order.id} ", admin_order_path(order) }
    column("Date", :updated_at)
    column("Delivery_Status")               {|order| status_tag(order.deli_status)}
    column("Customer", :user, :sortable => :user_id) {|order| order.user.email }
    column("Total")                   {|order| number_to_currency order.price }
  end

  show do
    panel "Invoice" do
      table_for(order.carts) do |t|
        t.column("Product") {|item| auto_link item.menu_item}
        t.column("Price") {|item| auto_link item.menu_item.price}

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
