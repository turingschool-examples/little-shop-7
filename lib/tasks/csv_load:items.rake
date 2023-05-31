require "csv"

namespace :csv_load do
  desc "Import Items Data from CSV"
  task :items => :environment do
    ActiveRecord::Base.connection.reset_pk_sequence!("Item")

    CSV.foreach("./db/data/items.csv", headers: true, header_converters: :symbol) do |row| 
      Item.create!(row.to_hash)
    end
  end
end