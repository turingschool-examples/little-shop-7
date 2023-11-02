require 'csv'

namespace :csv_load do
  desc "load invoices.csv into database"
  task invoices: :environment do
    file = "db/data/invoices.csv"
    CSV.foreach(file, headers: true) do |row|
       hash = row.to_hash
       Invoice.create!(hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end
end