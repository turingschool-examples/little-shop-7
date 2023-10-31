require 'csv'

namespace :csv_load do
  desc "load merchants.csv into database"
  task merchants: :environment do
    file = "db/data/merchants.csv"
    CSV.foreach(file, headers: true) do |row|
       hash = row.to_hash
       Merchant.create!(hash)
    end
  end
end