namespace :csv_load do
  desc "Load customers from CSV"
  task customers: :environment do
    require "csv"

    CSV.foreach("/db/data/customers.csv", headers: true) do |row|
      Customer.create!(row.to_h)
    end
    p "Customers loaded from CSV"
  end
end
