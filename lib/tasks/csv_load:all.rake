require "csv"

namespace :csv_load do
  desc "Run all CSV Imports"
  task :all => :environment do
    
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end

    CSV.foreach("./db/data/customers.csv", headers: true, header_converters: :symbol) do |row| 
      Customer.create!(row.to_hash) 
    end

    CSV.foreach("./db/data/merchants.csv", headers: true, header_converters: :symbol) do |row| 
      Merchant.create!(row.to_hash)
    end

    CSV.foreach("./db/data/invoices.csv", headers: true, header_converters: :symbol) do |row| 
      Invoice.create!(row.to_hash)
    end

    CSV.foreach("./db/data/items.csv", headers: true, header_converters: :symbol) do |row| 
      Item.create!(row.to_hash)
    end

    CSV.foreach("./db/data/invoice_items.csv", headers: true, header_converters: :symbol) do |row| 
      InvoiceItem.create!(row.to_hash)
    end

    CSV.foreach("./db/data/transactions.csv", headers: true, header_converters: :symbol) do |row| 
      Transaction.create!(row.to_hash)
    end
  end
end