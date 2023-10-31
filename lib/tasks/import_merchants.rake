namespace :csv_load do
  desc "TODO"
  task merchants: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join("db", "data", "merchants.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      t = Merchant.new
      t.name = row["name"]
      t.created_at = row["created_at"]
      t.updated_at = row["updated_at"]
      t.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end
  puts "Seeded bro bro bro bro bro"
end
