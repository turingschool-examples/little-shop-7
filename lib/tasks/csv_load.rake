require 'csv'

namespace :csv_load do 

  desc "load customers from CSV data"
  task customers: :environment do 
    #access CSV file
    file = "db/data/customers.csv"
    Customer.destroy_all
    #parse CSV file
    CSV.foreach(file, headers: true) do |row|
      #convert data into models for db
      Customer.create(row)
    end
    #reset pk sequence 
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    puts "Customers loaded from CSV"
  end
  
  desc "load invoice_items from CSV data"
  task invoice_items: :environment do 
    file = "db/data/invoice_items.csv"
    InvoiceItem.destroy_all
    CSV.foreach(file, headers: true) do |row|
      InvoiceItem.create(row)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    puts "Invoice Items loaded from CSV"
  end

  desc "load invoices from CSV data"
  task invoices: :environment do 
    file = "db/data/invoices.csv"
    Invoice.destroy_all
    CSV.foreach(file, headers: true) do |row|
      Invoice.create(row)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    puts "Invoices loaded from CSV"
  end

  desc "load items from CSV data"
  task items: :environment do 
      file = "db/data/items.csv"
      Item.destroy_all
        CSV.foreach(file, headers: true) do |row|
          Item.create(row)
      end
        ActiveRecord::Base.connection.reset_pk_sequence!('items')
      puts "Items loaded from CSV"
  end

  desc "load merchants from CSV data"
  task merchants: :environment do 
      file = "db/data/merchants.csv"
      Merchant.destroy_all
        CSV.foreach(file, headers: true) do |row|
          Merchant.create(row)
      end
        ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
      puts "Merchants loaded from CSV"
  end
  
  desc "load transactions from CSV data"
  task transactions: :environment do 
    file = "db/data/transactions.csv"
    Transaction.destroy_all
    CSV.foreach(file, headers: true) do |row|
      Transaction.create(row)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    puts "Transactions loaded from CSV"
  end

  desc "load all from CSV data"
  task all: do [:merchants, :customers, :items, :invoices, :invoice_items, :transactions]
    puts "All data loaded from CSV"
  end
end
