namespace :csv_load do
  desc "TODO"
  task merchants: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join('db', 'data', 'merchants.csv'))
    csv = CSV.parse(csv_text, headers:true, encoding: "ISO-8859-1")
    csv.each do |row|
      merchant = Merchant.new
      merchant.name = row['name']
      merchant.created_at = row['created_at']
      merchant.updated_at = row['updated_at']
      merchant.id = row['id']
      merchant.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end
  puts "merchants seeded"
end