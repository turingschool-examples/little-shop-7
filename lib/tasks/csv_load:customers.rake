require "csv"

namespace :csv_load do
  desc "Import Customer Data from CSV"
  task :customers => :environment do
    
    CSV.foreach("./db/data/customers.csv", headers: true, header_converters: :symbol) do |row| 
      Customer.create!(row.to_hash)
    end
    
    ActiveRecord::Base.connection.reset_pk_sequence!("Customer")
  end
end
