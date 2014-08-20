namespace :db do

  desc "deleve all unpurchased orders"
  task :delete_unpurchased => [:environment] do
    Order.delete_all(is_purchased=false)
  end

end
