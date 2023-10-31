require 'csv'

namespace :csv_load do
  desc "load customer.csv into database"
  task customers: :environment do
    file = "db/data/customers.csv"
    CSV.foreach(file, headers: true) do |row|
       hash = row.to_hash
       Customer.create!(hash)
    end
  end
end