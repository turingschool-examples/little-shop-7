namespace :csv_load do
  desc "Load Customers"
  task customers: :environment do
    require "csv"
    CSV.foreach("db/data/customers.csv", headers: :true) do |row|
      Customer.create!(
       row.to_hash
        )
    end
  end
end