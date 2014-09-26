ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do

      column do
        panel "Recent Orders" do
          table_for Order.where(is_purchased: true).order('id desc').limit(20) do
            column("Order", :sortable => :id) {|order| link_to "##{order.id} ", admin_order_path(order) }
            column("Customer"){|order| order.user.email }
            column("Total")   {|order| number_to_currency order.total_amount }
            column("Delivery_Status") {|order| status_tag(order.deli_status)}
            column("Order_Date")   {|order| order.updated_at.localtime}
          end
        end
      end

      column do
        panel "Recent Customers" do
          table_for User.order('id desc').limit(10).each do |customer|
            column(:email)    {|customer| customer.email }
          end
        end
      end

    end # columns

    columns do

      column do
        panel "Recent Orders" do
          table_for Order.where(is_purchased: true).order('id desc').limit(20) do
            column("Customer"){|order| order.user.email }
            column("Total")   {|order| number_to_currency order.total_amount }
            column("Order_Date")   {|order| order.updated_at.localtime}
          end
        end
      end

      column do
        panel "Engaged Customers" do
          table_for User.order('id desc').limit(10).each do |customer|
            column(:email)    {|customer| customer.email }
            column("Order_count")    {|customer| customer.orders.where(is_purchased: true).size }
          end
        end
      end

    end # columns

  end # content
end
