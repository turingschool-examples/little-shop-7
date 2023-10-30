# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'customers.csv'))
csv = CSV.parse(csv_text.scrub, headers:true)
csv.each do |row|
  customer = Customer.new
  customer.first_name = row['first_name']
  customer.last_name = row['last_name']
  customer.created_at = row['created_at']
  customer.updated_at = row['updated_at']
  customer.id = row['id']
  customer.save
end

puts "There are now #{Customer.count} rows in the transactions table"

csv_text = File.read(Rails.root.join('lib', 'seeds', 'invoice_items.csv'))
csv = CSV.parse(csv_text.scrub, headers:true)
csv.each do |row|
  invoice_item = InvoiceItem.new
  invoice_item.item_id = row['item_id']
  invoice_item.invoice_id = row['invoice_id']
  invoice_item.quantity = row['quantity']
  invoice_item.unit_price = row['unit_price']
  invoice_item.status = row['status']
  invoice_item.created_at = row['created_at']
  invoice_item.updated_at = row['updated_at']
  invoice_item.save
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'invoices.csv'))
csv = CSV.parse(csv_text.scrub, headers:true)
csv.each do |row|
invoice = Invoice.new
invoice.customer_id = row['customer_id']
invoice.status = row['status']
invoice.created_at = row['created_at']
invoice.updated_at = row['updated_at']
invoice.id = row['id']
invoice.save
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'items.csv'))
csv = CSV.parse(csv_text.scrub, headers:true)
csv.each do |row|
item = Item.new
item.name = row['name']
item.description = row['description']
item.unit_price = row['unit_price']
item.merchant_id = row['merchant_id']
item.created_at = row['created_at']
item.updated_at = row['updated_at']
item.id = row['id']
item.save
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'merchants.csv'))
csv = CSV.parse(csv_text.scrub, headers:true)
csv.each do |row|
  merchant = Merchant.new
  merchant.name = row['name']
  merchant.created_at = row['created_at']
  merchant.updated_at = row['updated_at']
  merchant.id = row['id']
  merchant.save
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'transactions.csv'))
csv = CSV.parse(csv_text.scrub, headers:true)
csv.each do |row|
  transaction = Transaction.new
  transaction.credit_card_number = row['Credit_card_number']
  transaction.credit_card_expiration_date = row['Credit_card_expiration_date']
  transaction.result = row['result']
  transaction.created_at = row['created_at']
  transaction.updated_at = row['updated_at']
  transaction.id = row['id']
  transaction.save
end