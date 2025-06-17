require 'csv'

namespace :csv_load do
  desc "Load merchants from CSV file"
  task merchants: :environment do

    file_path = Rails.root.join('db', 'data', 'merchants.csv')
    puts "Loading merchants from #{file_path}"

    # Clear existing data to avoid duplicates (optional)
    Merchant.delete_all

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Merchant.create!(
        id: row[:id],
        name: row[:name],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      )
    end

    # Reset primary key sequence to avoid conflicts when inserting new data
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')

    puts "Finished loading merchants."
  end

  task customers: :environment do

    file_path = Rails.root.join('db', 'data', 'customers.csv')
    puts "Loading customers from #{file_path}"

    Customer.delete_all

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Customer.create!(
        id: row[:id],
        first_name: row[:first_name],
        last_name: row[:last_name],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      )
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('customers')

    puts "Finished loading customers."
  end

  desc "Load invoices from CSV file"
    task invoices: :environment do
    file_path = Rails.root.join('db', 'data', 'invoices.csv')
    puts "Loading invoices from #{file_path}"

    Invoice.delete_all
        CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Invoice.create!(
        id: row[:id],
        customer_id: row[:customer_id],
        status: row[:status].parameterize.underscore.to_sym,
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      )
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    puts "Finished loading invoices."
  end
  
  desc "Load items from CSV file"
task items: :environment do
  file_path = Rails.root.join('db', 'data', 'items.csv')
  puts "Loading items from #{file_path}"

  Item.delete_all

  CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
    Item.create!(
      id: row[:id],
      name: row[:name],
      description: row[:description],
      unit_price: row[:unit_price],
      merchant_id: row[:merchant_id],
      created_at: row[:created_at],
      updated_at: row[:updated_at]
    )
  end

  ActiveRecord::Base.connection.reset_pk_sequence!('items')
  puts "Finished loading items."
end

  desc "Load invoice_items from CSV file"
task invoice_items: :environment do
  file_path = Rails.root.join('db', 'data', 'invoice_items.csv')
  puts "Loading invoice_items from #{file_path}"

  InvoiceItem.delete_all

  CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
    InvoiceItem.create!(
      id: row[:id],
      item_id: row[:item_id],
      invoice_id: row[:invoice_id],
      quantity: row[:quantity],
      unit_price: row[:unit_price],
      status: InvoiceItem.statuses[row[:status]],
      created_at: row[:created_at],
      updated_at: row[:updated_at]
    )
  end

  ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  puts "Finished loading invoice_items."
end

desc "Load transactions from CSV file"
task transactions: :environment do
  file_path = Rails.root.join('db', 'data', 'transactions.csv')
  puts "Loading transactions from #{file_path}"

  Transaction.delete_all

  CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
    Transaction.create!(
      id: row[:id],
      invoice_id: row[:invoice_id],
      credit_card_number: row[:credit_card_number],
      credit_card_expiration_date: row[:credit_card_expiration_date],
      result: Transaction.results[row[:result]],
      created_at: row[:created_at],
      updated_at: row[:updated_at]
    )
  end

  ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  puts "Finished loading transactions."
end


  

  desc "Load all CSV files"
    task all: [
    'csv_load:merchants',
    'csv_load:customers',
    'csv_load:invoices',
    'csv_load:items',
    'csv_load:invoice_items',
    'csv_load:transactions'
    ]
end  # 👈 this closes the namespace block

def delete_all_in_order
  [InvoiceItem, Transaction, Item, Invoice, Customer, Merchant].each(&:delete_all)
end