require 'csv'

namespace :csv_load do
  desc 'Load data from CSV into seeds'
  
  task customers: :environment do
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
    puts "Customer CSV loaded successfully."
  end
  
  task invoices: :environment do
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
    puts "Invoice CSV loaded successfully."
  end
  
  task merchants: :environment do
    CSV.foreach("db/data/merchants.csv", headers: true) do |merchant| 
      Merchant.create!(
        id: merchant["id"],
        name: merchant["name"], 
        created_at: merchant["created_at"],
        updated_at: merchant["updated_at"]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    puts "Merchant CSV loaded successfully."
  end
  
  task items: :environment do
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
    puts "Item CSV loaded successfully."
  end
  
  task invoice_items: :environment do
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
    puts "InvoiceItem CSV loaded successfully."
  end
  
  task transactions: :environment do
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
    puts "Transaction CSV loaded successfully."
  end
  
  task all: [:customers, :invoices, :merchants, :items, :invoice_items, :transactions] do
    #puts "All CSVs loaded successfully."
  end
end