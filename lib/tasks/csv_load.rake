namespace :csv_load do
  desc "Load merchants from CSV file"
  task merchants: :environment do
    require 'csv'

    file_path = Rails.root.join('db', 'data', 'merchants.csv')
    puts "Loading merchants from #{file_path}"

    # Clear existing data to avoid duplicates (optional)
    Merchant.delete_all

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Merchant.create!(
        id: row[:id],
        name: row[:name],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      )
    end

    # Reset primary key sequence to avoid conflicts when inserting new data
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')

    puts "Finished loading merchants."
  end
  task customers: :environment do
    require 'csv'

    file_path = Rails.root.join('db', 'data', 'customers.csv')
    puts "Loading customers from #{file_path}"

    Customer.delete_all

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Customer.create!(
        id: row[:id],
        first_name: row[:first_name],
        last_name: row[:last_name],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      )
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('customers')

    puts "Finished loading customers."
  end
end
