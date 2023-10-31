namespace :csv_load do
  desc "TODO"
  task invoice_items: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join('db', 'data', 'invoice_items.csv'))
    csv = CSV.parse(csv_text, headers:true, encoding: "ISO-8859-1")
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
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end
  puts "invoice items seeded"
end