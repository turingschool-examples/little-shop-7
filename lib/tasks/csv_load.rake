require 'csv'

namespace :csv_load do 
  desc "load customers from csv file"
  task customers: :environment do
    Customer.destroy_all
    file_path = Rails.root.join("db", "data", "customers.csv")
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Customer.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    puts "Customer loaded successfully"
  end

  desc "load merchants from csv file"
  task merchants: :environment do
    Merchant.destroy_all
    file_path = Rails.root.join("db", "data", "merchants.csv")
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    puts "Merchant loaded successfully"
  end
end