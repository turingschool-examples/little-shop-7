require 'csv'

namespace :csv_load do 
  desc "load customers from csv file"
  task customers: :environment do
    Customer.destroy_all
    CSV.foreach("db/data/customers.csv", headers: true, header_converters: :symbol) do |row|
      Customer.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    puts "Customer loaded successfully"
  end

  desc "load merchants from csv file"
  task merchants: :environment do
    Merchant.destroy_all
    CSV.foreach("db/data/merchants.csv", headers: true, header_converters: :symbol) do |row|
      Merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    puts "Merchant loaded successfully"
  end
end