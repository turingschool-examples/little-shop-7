require 'csv'

namespace :csv_load do 
  desc "load customers from csv file"
  task customers: :environment do
    Customer.destroy_all
    CSV.foreach("db/data/customers.csv", headers: true, header_converters: :symbol) do |row|
      Customer.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    puts "Customer loaded successfully"
  end

  desc "load merchants from csv file"
  task merchants: :environment do
    Merchant.destroy_all
    CSV.foreach("db/data/merchants.csv", headers: true, header_converters: :symbol) do |row|
      Merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    puts "Merchant loaded successfully"
  end

  desc "load items from csv file"
  task items: :environment do
    Item.destroy_all
    CSV.foreach("db/data/items.csv", headers: true, header_converters: :symbol) do |row|
      Item.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    puts "Items loaded successfully"
  end
  
  desc "load invoices from csv file"
  task invoices: :environment do
    Invoice.destroy_all
    CSV.foreach("db/data/invoices.csv", headers: true, header_converters: :symbol) do |row|
      Invoice.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    puts "Invoices loaded successfully"
  end
end