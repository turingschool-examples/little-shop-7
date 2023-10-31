namespace :csv_load do
  desc "TODO"
  task items: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join("db", "data", "items.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      t = Item.new
      t.name = row["name"]
      t.description = row["description"]
      t.unit_price = row["unit_price"]
      t.merchant_id = row["merchant_id"]
      t.created_at = row["created_at"]
      t.updated_at = row["updated_at"]
      t.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end
  puts "Seeded bro bro bro bro"
end
