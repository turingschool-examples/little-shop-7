require 'csv'

namespace :csv_load do
  desc "Load customers CSV file into database"
  task :customers => :environment do
  ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    customer_data = CSV.open('./db/data/customers.csv')
    CSV.foreach('./db/data/customers.csv', :headers => true) do |row|
      customer = Customer.new(row.to_hash)
      customer.id = row[:id]
      customer.save
    end
  end
  desc "Load merchants CSV file into database"
  task :merchants => :environment do
    merchant_data = CSV.open('./db/data/merchants.csv')
    CSV.foreach('./db/data/merchants.csv', :headers => true) do |row|
      Merchant.create!(row.to_hash)
    end
  end
  desc "Load items CSV file into database"
  task :items => :environment do
    item_data = CSV.open('./db/data/items.csv')
    CSV.foreach('./db/data/items.csv', :headers => true) do |row|
      Item.create!(row.to_hash)
    end
  end
  desc "Load invoices CSV file into database"
  task :invoices => :environment do
    invoice_data = CSV.open('./db/data/invoices.csv')
    CSV.foreach('./db/data/invoices.csv', :headers => true) do |row|
      Invoice.create!(row.to_hash)
    end
  end
  desc "Load transactions CSV file into database"
  task :transactions => :environment do
    transaction_data = CSV.open('./db/data/transactions.csv')
    CSV.foreach('./db/data/transactions.csv', :headers => true) do |row|
      Transaction.create!(row.to_hash)
    end
  end
  desc "Load invoice_items CSV file into database"
  task :invoice_items => :environment do
    invoice_item_data = CSV.open('./db/data/invoice_items.csv')
    CSV.foreach('./db/data/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  task :all => :environment do
    Rake::Task['csv_load:customers'].invoke
    Rake::Task['csv_load:merchants'].invoke
    Rake::Task['csv_load:items'].invoke
    Rake::Task['csv_load:invoices'].invoke
    Rake::Task['csv_load:transactions'].invoke
    Rake::Task['csv_load:invoice_items'].invoke
  end
end