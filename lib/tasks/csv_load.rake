require 'csv'

namespace :csv_load do 

  desc "load customers"
  task customers: :environment do 
    #access CSV file
    file = "db/data/customers.csv"
    Customer.destroy_all
    #parse CSV file
    CSV.foreach(file, headers: true) do |row|
      #convert data into models for db
      Customer.create(row.to_h)
    end
    #reset pk sequence 
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    puts "done"
  end
  
  desc "load invoice_items"
  task invoice_items: :environment do 
    #access CSV file
    file = "db/data/invoice_items.csv"
    InvoiceItem.destroy_all
    #parse CSV file
    CSV.foreach(file, headers: true) do |row|
      #convert data into models for db
      InvoiceItem.create(row.to_h)
    end
    #reset pk sequence 
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    puts "done"
  end

  desc "load invoices"
  task invoices: :environment do 
    #access CSV file
    file = "db/data/invoices.csv"
    Invoice.destroy_all
    #parse CSV file
    CSV.foreach(file, headers: true) do |row|
      #convert data into models for db
      Invoice.create(row.to_h)
    end
    #reset pk sequence 
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    puts "done"
  end

  desc "load items"
  task items: :environment do 
      #access CSV file
      file = "db/data/items.csv"
      Item.destroy_all
      #parse CSV file
      CSV.foreach(file, headers: true) do |row|
        #convert data into models for db
        Item.create(row.to_h)
      end
      #reset pk sequence 
      ActiveRecord::Base.connection.reset_pk_sequence!('items')
      puts "done"
  end

  desc "load merchants"
  task merchants: :environment do 
      #access CSV file
      file = "db/data/merchants.csv"
      Merchant.destroy_all
      #parse CSV file
      CSV.foreach(file, headers: true) do |row|
        #convert data into models for db
        Merchant.create(row.to_h)
      end
      #reset pk sequence 
      ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
      puts "done"
  end
  
  desc "load transactions"
  task transactions: :environment do 
    #access CSV file
    file = "db/data/transactions.csv"
    Transaction.destroy_all
    #parse CSV file
    CSV.foreach(file, headers: true) do |row|
      #convert data into models for db
      Transaction.create(row.to_h)
    end
    #reset pk sequence 
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    puts "done"
  end

  desc "load all"
  # task :all do 
  #   Rake::Task
    task all: [:merchants, :customers, :items, :invoices, :invoice_items, :transactions]
  end

end



# desc "leafblower"
# task csv_load: [:merchants, :customers, :items, :invoices, :invoice_items, :transactions] do 


# end