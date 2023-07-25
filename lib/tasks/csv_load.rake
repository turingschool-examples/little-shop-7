require 'csv'

namespace :csv_load do

  desc "All"
  task all: [:customers, :invoice_items, :invoices, :items, :merchants, :transactions] do
    
  end

  desc "TODO"
  task customers: :environment do
    csv_text = File.read("db/data/customers.csv")
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    # customer = Customer
    # Customer.connection.execute("ALTER SEQUENCE #{Customer.customers}_id_seq RESTART WITH 1")
    csv.each do |row|
      Customer.create(row)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  desc "TODO"
  task invoice_items: :environment do 
    csv_text = File.read("db/data/invoice_items.csv")
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    csv.each do |row|
      InvoiceItem.create(row)
    end
  end

  desc "TODO"
  task invoices: :environment do    
    csv_text = File.read("db/data/invoices.csv")
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    csv.each do |row|
      Invoice.create(row)
    end
  end

  desc "TODO"
  task items: :environment do    
    csv_text = File.read("db/data/items.csv")
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    csv.each do |row|
      Item.create(row)
    end
  end

  desc "TODO"
  task merchants: :environment do    
    csv_text = File.read("db/data/merchants.csv")
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    csv.each do |row|
      Merchant.create(row)
    end
  end

  desc "TODO"
  task transactions: :environment do    
    csv_text = File.read("db/data/transactions.csv")
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    csv.each do |row|
      Transaction.create(row)
    end
  end
end
