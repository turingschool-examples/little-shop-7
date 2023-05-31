require "csv"

namespace :csv_load do
  desc "cutomers"
  task customers: :environment do
    csv_text = File.read(Rails.root.join("db", "data", "customers.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = Customer.new
      t.first_name = row["first_name"]
      t.last_name = row["last_name"]
      t.created_at = row["created_at"]
      t.updated_at = row["updated_at"]
      t.save
      puts "#{t.first_name} #{t.last_name} saved"
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(‘customers’)
  end
  # task invoice_items: :environment do
  desc "invoice items"
  task invoice_items: :environment do
    csv_text = File.read(Rails.root.join("db", "data", "invoice_items.csv"))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = InvoiceItem.new
      t.item_id = row["item_id"]
      t.invoice_id = row["invoice_id"] 
      t.quantity = row["quantity"] 
      t.unit_price = row["unit_price"] 
      t.status = row["status"]
      t.save
      puts "invoice_items csv loaded"
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end
  
  # end
  
  # task invoices: :environment do
  desc 'invoices'
  task invoices: :environment do 
    csv_text = File.read(Rails.root.join('db', 'data', 'invoices.csv'))
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      t = Invoice.new
      t.customer_id = row['customer_id']
      t.status = row['status']
      t.save
      puts 'invoices loaded'
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end
  # end
  
  # task items: :environment do
  # end
  
  # task merchants: :environment do
  # end
  
  # task transactions: :environment do
  # end
end
