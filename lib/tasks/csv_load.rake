require "csv"

namespace :csv_load do
  desc "Load customers CSV data into the database"
  task :customers => :environment do
    file_path = "db/data/customers.csv"
    CSV.foreach(file_path, headers: true) do |row|
      attributes = row.to_hash
      Customer.create!(attributes)
      require 'pry'; binding.pry
    end
    reset_pk_sequence!(Customer)
  end

  desc "Load invoice items CSV data into the database"
  task :invoice_items => :environment do
    file_path = "db/data/invoice_items.csv"
    CSV.foreach(file_path, headers: true) do |row|
      attributes = row.to_hash
      InvoiceItem.create!(attributes)
    end
    reset_pk_sequence!(InvoiceItem)
  end

  desc "Load invoices CSV data into the database"
  task :invoices => :environment do
    file_path = "db/data/invoices.csv"
    CSV.foreach(file_path, headers: true) do |row|
      attributes = row.to_hash
      Invoice.create!(attributes)
    end
    reset_pk_sequence!(Invoices)
  end

  desc "Load items CSV data into the database"
  task :items => :environment do
    file_path = "db/data/items.csv"
    CSV.foreach(file_path, headers: true) do |row|
      attributes = row.to_hash
      Item.create!(attributes)
    end
    reset_pk_sequence!(Item)
  end

  desc "Load merchants CSV data into the database"
  task :merchants => :environment do
    file_path = "db/data/merchants.csv"
    CSV.foreach(file_path, headers: true) do |row|
      attributes = row.to_hash
      Merchant.create!(attributes)
    end
    reset_pk_sequence!(Merchant)
  end

  desc "Load transactions CSV data into the database"
  task :transactions => :environment do
    file_path = "db/data/transactions.csv"
    CSV.foreach(file_path, headers: true) do |row|
      attributes = row.to_hash
      require 'pry'; binding.pry
      Transaction.create!(attributes)
    end
    reset_pk_sequence!(Transaction)
  end
end
