namespace :csv_load do
  desc "TODO"
  task invoices: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join('db', 'data', 'invoices.csv'))
    csv = CSV.parse(csv_text, headers:true, encoding: "ISO-8859-1")
    csv.each do |row|
      invoice = Invoice.new
      invoice.customer_id = row['customer_id']
      invoice.status = row['status']
      invoice.created_at = row['created_at']
      invoice.updated_at = row['updated_at']
      invoice.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end
  puts "invoices seeded"
end