namespace :csv_load do

  desc "Load All"
  task all: [:customers, :merchants, :items, :invoices, :invoice_items, :transactions] do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

  desc "Load Customers"
  task customers: :environment do
    require "csv"
    CSV.foreach("db/data/customers.csv", headers: :true) do |row|
      Customer.create!(
       row.to_hash
        )
    end
  end

  desc "Load Merchants"
  task merchants: :environment do
    require "csv"
    CSV.foreach("db/data/merchants.csv", headers: :true) do |row|
      Merchant.create!(
       row.to_hash
        )
    end
  end

  desc "Load Items"
  task items: :environment do
    require "csv"
    CSV.foreach("db/data/items.csv", headers: :true) do |row|
      Item.create!(
       row.to_hash
        )
    end
  end

  desc "Load Invoices"
  task invoices: :environment do
    require "csv"
    CSV.foreach("db/data/invoices.csv", headers: :true) do |row|
      Invoice.create!(
       row.to_hash
        )
    end
  end

  desc "Load Invoice Items"
  task invoice_items: :environment do
    require "csv"
    CSV.foreach("db/data/invoice_items.csv", headers: :true) do |row|
      InvoiceItem.create!(
       row.to_hash
        )
    end
  end

  desc "Load Transactions"
  task transactions: :environment do
    require "csv"
    CSV.foreach("db/data/transactions.csv", headers: :true) do |row|
      Transaction.create!(
       row.to_hash
        )
    end
  end
end