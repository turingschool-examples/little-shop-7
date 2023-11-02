require 'csv'

namespace :csv_load do
  desc "load transactions.csv into database"
  task transactions: :environment do
    file = "db/data/transactions.csv"
    CSV.foreach(file, headers: true) do |row|
       hash = row.to_hash
       Transaction.create!(hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end
end