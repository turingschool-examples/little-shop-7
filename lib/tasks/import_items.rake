namespace :csv_load do
  desc "TODO"
  task items: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join('db', 'data', 'items.csv'))
    csv = CSV.parse(csv_text, headers:true, encoding: "ISO-8859-1")
    csv.each do |row|
      item = Item.new
      item.name = row['name']
      item.description = row['description']
      item.unit_price = row['unit_price']
      item.merchant_id = row['merchant_id']
      item.created_at = row['created_at']
      item.updated_at = row['updated_at']
      item.id = row['id']
      item.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end
  puts "items seeded"
end