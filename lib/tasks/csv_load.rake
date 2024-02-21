require "csv"

namespace :csv_load do

  desc "loads customer data"
  task customers: :environment do
    CSV.foreach("db/data/customers.csv", headers: true) do |row|
      Customer.create!(row.to_hash)
      reset_pk("customers")
    end 
  end

  desc "loads invoice_items data"
  task :invoice_items do
    CSV.foreach("db/data/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
      reset_pk("invoice_items")
    end 
  end
 
  desc "loads invoices data"
  task :invoices do
    CSV.foreach("db/data/invoices.csv", headers: true) do |row|
      Invoice.create!(row.to_hash)
      reset_pk("invoices")
    end 
  end

  desc "loads items data"
  task :items do
    CSV.foreach("db/data/items.csv", headers: true) do |row|
      Item.create!(row.to_hash)
      reset_pk("items")
    end 
  end

  desc "loads merchant data"
  task :merchants do
    CSV.foreach("db/data/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_hash)
      reset_pk("merchants")
    end 
  end

  desc "loads transaction data"
  task :transactions do
    CSV.foreach("db/data/transactions.csv", headers: true) do |row|
      Transaction.create!(row.to_hash)
      reset_pk("transactions")
    end 

  end
end

def reset_pk(table_name)
  ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
end