namespace :csv_load do

  desc "Load customers from CSV"
  task customers: [:environment] do
    require "csv"

    CSV.foreach("./db/data/customers.csv", headers: true) do |row|
      Customer.create!(row.to_h)
      # Customer.create!(first_name: row[:first_name], last_name: row[:last_name], id: row[:id])
    end
    p "Customers loaded from CSV"
  end

  desc "Load invoice items from CSV"
  task invoice: [:environment] do
    require "csv"

    CSV.foreach("./db/data/invoices.csv", headers: true) do |row|
      Invoice.create!(row.to_h)
      # Customer.create!(first_name: row[:first_name], last_name: row[:last_name], id: row[:id])
    end
    p "Invoice loaded from CSV"
  end
end
