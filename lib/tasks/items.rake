require 'csv'

namespace :csv_load do
  desc "load items.csv into database"
  task items: :environment do
    file = "db/data/items.csv"
    CSV.foreach(file, headers: true) do |row|
       hash = row.to_hash
       Item.create!(hash)
    end
  end
end