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
      # attributes = (
      # id = row[:id],
      # customer_id = row[:customer_id],
      # unit_price = row[:unit_price],
      # status = row[:status]
      # )

      Invoice.create!(row.to_hash)
      reset_pk("invoices")
    end 
  end

  desc "loads items data"
  task :items do
    CSV.foreach("db/data/items.csv", headers: true) do |row|
      # attributes = (
      # id = row[:id],
      # name = row[:name],
      # description = row[:description],
      # unit_price = row[:unit_price],
      # merchant_id = row[:merchant_id]
      # )
      
      Item.create!(row.to_hash)
      reset_pk("items")

    end 
  end

  desc "loads merchant data"
  task :merchants do

    CSV.foreach("db/data/merchants.csv", headers: true) do |row|
      # attributes = (
      # id = row[:id],
      # name = row[:name]
      # )

      Merchant.create!(row.to_hash)
      reset_pk("merchants")
    end 
  end

  desc "loads transaction data"
  task :transactions do
    CSV.foreach("db/data/transactions.csv", headers: true) do |row|
      attributes = (
      id = row[:id],
      invoice_id = row[:invoice_id],
      credit_card_number = row[:credit_card_number],
      credit_card_expiration_date = row[:credit_card_expiration_date],
      result = row[:result]

      )

      Transaction.create!(row.to_hash)
      reset_pk("transactions")
    end 

  end
end

def reset_pk(table_name)
  ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
end