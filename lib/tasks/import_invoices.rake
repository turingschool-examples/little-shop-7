namespace :csv_load do
  desc "TODO"
  task invoices: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join("db", "data", "invoices.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      t = Invoice.new
      t.customer_id = row["customer_id"]
      t.status = row["status"]
      t.created_at = row["created_at"]
      t.updated_at = row["updated_at"]
      t.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end
  puts "Seeded bro bro bro"
end
