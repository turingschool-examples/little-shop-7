namespace :csv_load do
  desc "TODO"
  task customers: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join('db', 'data', 'customers.csv'))
    csv = CSV.parse(csv_text, headers:true, encoding: "ISO-8859-1")
    csv.each do |row|
      customer = Customer.new
      customer.first_name = row['first_name']
      customer.last_name = row['last_name']
      customer.created_at = row['created_at']
      customer.updated_at = row['updated_at']
      customer.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
  puts "customers seeded"
end