require "csv"

namespace :csv_load do
  desc "Import Transactions Data from CSV"
  task :transactions => :environment do
    
    CSV.foreach("./db/data/transactions.csv", headers: true, header_converters: :symbol) do |row| 
      Transaction.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("Transaction")
  end
end