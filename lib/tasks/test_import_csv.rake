# lib/tasks/test_import_csv.rake

require 'csv'
require 'rspec/core/rake_task' 

RSpec::Core::RakeTask.new(csv_load_to_test: :all) do |t| 
  t.rspec_opts = "--require spec/rake_spec_helper.rb" 
end

namespace :csv_load_to_test do
  desc 'Load data from CSV into seeds for testing purposes'
  
  task customers: :environment do
    Customer.delete_all
    CSV.foreach("db/data/customers.csv", headers: true) do |customer|
      
      Customer.create!(
        id: customer["id"],
        first_name: customer["first_name"],
        last_name: customer["last_name"],
        created_at: customer["created_at"],
        updated_at: customer["updated_at"]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    puts "Customer CSVs loaded successfully."
  end
  
  task invoices: :environment do
    Invoice.delete_all
    CSV.foreach("db/data/invoices.csv", headers: true) do |invoice| 
      
      Invoice.create!(
        id: invoice["id"],
        customer_id: invoice["customer_id"], 
        status: invoice["status"],
        created_at: invoice["created_at"],
        updated_at: invoice["updated_at"]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    puts "Invoice CSVs loaded successfully."
  end
  
  task merchants: :environment do
    Merchant.delete_all
    CSV.foreach("db/data/merchants.csv", headers: true) do |merchant| 
      
      Merchant.create!(
        id: merchant["id"],
        name: merchant["name"], 
        created_at: merchant["created_at"],
        updated_at: merchant["updated_at"]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    puts "Merchant CSVs loaded successfully."
  end
  
  task items: :environment do
    Item.delete_all
    CSV.foreach("db/data/items.csv", headers: true) do |item| 
      
      Item.create!(
        id: item["id"],
        name: item["name"], 
        description: item["description"], 
        unit_price: item["unit_price"],
        merchant_id: item["merchant_id"],
        created_at: item["created_at"],
        updated_at: item["updated_at"]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    puts "Item CSVs loaded successfully."
  end
  
  task transactions: :environment do
    Transaction.delete_all
    CSV.foreach("db/data/transactions.csv", headers: true) do |transaction| 
      
      Transaction.create!(
        id: transaction["id"],
        invoice_id: transaction["invoice_id"], 
        credit_card_number: transaction["credit_card_number"], 
        credit_card_expiration_date: transaction["credit_card_expiration_date"],
        result: transaction["result"],
        created_at: transaction["created_at"],
        updated_at: transaction["updated_at"]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    puts "Transaction CSVs loaded successfully."
  end
  
  task invoice_items: :environment do
    InvoiceItem.delete_all
    CSV.foreach("db/data/invoice_items.csv", headers: true) do |invoice_item| 
      
      InvoiceItem.create!(
        id: invoice_item["id"],
        item_id: invoice_item["item_id"], 
        invoice_id: invoice_item["invoice_id"], 
        quantity: invoice_item["quantity"], 
        unit_price: invoice_item["unit_price"],
        status: invoice_item["status"],
        created_at: invoice_item["created_at"],
        updated_at: invoice_item["updated_at"]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    puts "InvoiceItem CSVs loaded successfully."
  end

  task all: [:customers, :invoices, :merchants, :items, :invoice_items,  :transactions] do
    #puts "All CSVs loaded successfully."
  end
end
