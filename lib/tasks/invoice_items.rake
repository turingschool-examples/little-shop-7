require 'csv'

namespace :csv_load do
  desc "load invoice_items.csv into database"
  task invoice_items: :environment do
    file = "db/data/invoice_items.csv"
    CSV.foreach(file, headers: true) do |row|
       hash = row.to_hash
       InvoiceItem.create!(hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end
end