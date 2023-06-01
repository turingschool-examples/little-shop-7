require "csv"

namespace :csv_load do
  desc "Import Merchants Data from CSV"
  task :merchants => :environment do
    ActiveRecord::Base.connection.reset_pk_sequence!("Merchant")

    CSV.foreach("./db/data/merchants.csv", headers: true, header_converters: :symbol) do |row| 
      Merchant.create!(row.to_hash)
    end
  end
end