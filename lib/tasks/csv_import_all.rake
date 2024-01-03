require 'csv'

namespace :csv_import do
  task all: [:customers, :invoices, :invoice_items, :items, :merchants, :transactions]
  task customers: :environment do
    filename = 'db/data/customers.csv'

    CSV.foreach(filename, headers: true) do |row|
      Customer.create!(row.to_hash)
    end

    reset_primary_key_sequence('customers')
  end

  task invoices: :environment do
    filename = 'db/data/invoices.csv'

    CSV.foreach(filename, headers: true) do |row|
      Invoice.create!(row.to_hash)
    end

    reset_primary_key_sequence('invoices')
  end

  task invoice_items: :environment do
    filename = 'db/data/invoice_items.csv'

    CSV.foreach(filename, headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end

    reset_primary_key_sequence('invoice_items')
  end

  task items: :environment do
    filename = 'db/data/items.csv'

    CSV.foreach(filename, headers: true) do |row|
      Item.create!(row.to_hash)
    end

    reset_primary_key_sequence('items')
  end

  task merchants: :environment do
    filename = 'db/data/merchants.csv'

    CSV.foreach(filename, headers: true) do |row|
      Merchant.create!(row.to_hash)
    end

    reset_primary_key_sequence('merchants')
  end

  task transactions: :environment do
    filename = 'db/data/transactions.csv'

    CSV.foreach(filename, headers: true) do |row|
      Transaction.create!(row.to_hash)
    end

    reset_primary_key_sequence('transactions')
  end
end

def reset_primary_key_sequence(table_name)
  ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
end