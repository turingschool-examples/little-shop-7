require "csv"

namespace :csv_load do
  desc "Load customers CSV data into the database"
  task :customers => :environment do
    Customer.destroy_all
    file_path = "db/data/customers.csv"
    CSV.foreach(file_path, headers: true) do |row|
      attributes = row.to_hash
      Customer.create!(attributes)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("customers")
  end

  desc "Load invoice items CSV data into the database"
  task :invoice_items => :environment do
    InvoiceItem.destroy_all
    file_path = "db/data/invoice_items.csv"
    CSV.foreach(file_path, headers: true) do |row|
      attributes = row.to_hash
      InvoiceItem.create!(attributes)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("invoice_item")
  end

  desc "Load invoices CSV data into the database"
  task :invoices => :environment do
    Invoice.destroy_all
    file_path = "db/data/invoices.csv"
    CSV.foreach(file_path, headers: true) do |row|
      attributes = row.to_hash
      Invoice.create!(attributes)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("invoices")
  end

  desc "Load items CSV data into the database"
  task :items => :environment do
    Item.destroy_all
    file_path = "db/data/items.csv"
    CSV.foreach(file_path, headers: true) do |row|
      attributes = row.to_hash
      Item.create!(attributes)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("item")
  end

  desc "Load merchants CSV data into the database"
  task :merchants => :environment do
    Merchant.destroy_all
    file_path = "db/data/merchants.csv"
    CSV.foreach(file_path, headers: true) do |row|
      attributes = row.to_hash
      Merchant.create!(attributes)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("merchant")
  end

  desc "Load transactions CSV data into the database"
  task :transactions => :environment do
    Transaction.destroy_all
    file_path = "db/data/transactions.csv"
    CSV.foreach(file_path, headers: true) do |row|
      attributes = row.to_hash
      Transaction.create!(attributes)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("transaction")
  end
end
