require 'csv'

namespace :import do
  desc "Import customers from csv file"
    task customers: :environment do

      file = "db/data/customers.csv"

      CSV.foreach(file, headers: true) do |row|
        Customer.create(
        id: row['id'],
        first_name: row['first_name'],
        last_name: row['last_name'],
        created_at: DateTime.parse(row['created_at']),
        updated_at: DateTime.parse(row['updated_at'])
        )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  desc "Import merchants from csv file"
    task merchants: :environment do

      file = "db/data/merchants.csv"

      CSV.foreach(file, headers: true) do |row|
        Merchant.create(
        id: row['id'],
        name: row['name'],
        created_at: DateTime.parse(row['created_at']),
        updated_at: DateTime.parse(row['updated_at'])
        )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  desc "Import items from csv file"
    task items: :environment do

      file = "db/data/items.csv"

      CSV.foreach(file, headers: true) do |row|
        Item.create(
        id: row['id'],
        name: row['name'],
        description: row['description'],
        unit_price: row['unit_price'],
        merchant_id: row['merchant_id'],
        created_at: DateTime.parse(row['created_at']),
        updated_at: DateTime.parse(row['updated_at'])
        )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  desc "Import invoices from csv file"
    task invoices: :environment do

      file = "db/data/invoices.csv"

      CSV.foreach(file, headers: true) do |row|
        Invoice.create(
          id: row['id'],
          customer_id: row['customer_id'],
          status: row['status'].underscore,
          created_at: DateTime.parse(row['created_at']),
          updated_at: DateTime.parse(row['updated_at'])
        )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice')
  end

  desc "Import transactions from csv file"
    task transactions: :environment do

      file = "db/data/transactions.csv"

      CSV.foreach(file, headers: true) do |row|
        Transaction.create(
          id: row['id'],
          invoice_id: row['invoice_id'],
          credit_card_number: row['credit_card_number'],
          credit_card_expiration_date: row['credit_card_expiration_date'],
          result: row['result'],
          created_at: DateTime.parse(row['created_at']),
          updated_at: DateTime.parse(row['updated_at'])
        )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  desc "Import invoice_items from csv file"
    task invoice_items: :environment do

      file = "db/data/invoice_items.csv"

      CSV.foreach(file, headers: true) do |row|
        InvoiceItem.create(
          id: row['id'],
          item_id: row['item_id'],
          invoice_id: row['invoice_id'],
          quantity: row['quantity'],
          unit_price: row['unit_price'],
          status: row['status'],
          created_at: DateTime.parse(row['created_at']),
          updated_at: DateTime.parse(row['updated_at'])
        )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  desc "Run multiple Rake tasks at once"
    task :all => [:customers, :merchants, :items, :invoices, :invoice_items, :transactions] do
    puts "All tasks have been executed successfully"
  end
end
