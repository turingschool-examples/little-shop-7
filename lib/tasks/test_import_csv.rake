# lib/tasks/test_import_csv.rake

require 'csv'
require 'rspec/core/rake_task' 

RSpec::Core::RakeTask.new(csv_load_to_test:all) do |t| 
  t.rspec_opts = "--require spec/rake_spec_helper.rb" 
end

namespace :csv_load_to_test do
  desc 'Load data from CSV into seeds for testing purposes'

  task customers: :environment do
    counter = 0
    CSV.foreach("db/data/customers.csv", headers: true) do |customer|
      counter += 1
      next if counter % 5 != 0

      Customer.create!(
        id: customer["id"],
        first_name: customer["first_name"],
        last_name: customer["last_name"],
        created_at: customer["created_at"],
        updated_at: customer["updated_at"]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  task invoice_items: :environment do
    counter = 0
    CSV.foreach("db/data/invoice_items.csv", headers: true) do |invoice_item| 
      counter += 1
      next if counter % 5 != 0

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
  end

  task invoices: :environment do
    counter = 0
    CSV.foreach("db/data/invoices.csv", headers: true) do |invoice| 
      counter += 1
      next if counter % 5 != 0

      Invoice.create!(
      id: invoice["id"],
      customer_id: invoice["customer_id"], 
      status: invoice["status"],
      created_at: invoice["created_at"],
      updated_at: invoice["updated_at"]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  task items: :environment do
    counter = 0
    CSV.foreach("db/data/items.csv", headers: true) do |item| 
      counter += 1
      next if counter % 5 != 0

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
  end

  task merchants: :environment do
    counter = 0
    CSV.foreach("db/data/merchants.csv", headers: true) do |merchant| 
      counter += 1
      next if counter % 5 != 0

      Merchant.create!(
      id: merchant["id"],
      name: merchant["name"], 
      created_at: merchant["created_at"],
      updated_at: merchant["updated_at"]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  task transactions: :environment do
    counter = 0
    CSV.foreach("db/data/transactions.csv", headers: true) do |transaction| 
      counter += 1
      next if counter % 5 != 0

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
  end
  task all: [:customers, :invoice_items, :invoices, :items, :merchants, :transactions] do
    puts "All CSVs loaded successfully."
  end
end
