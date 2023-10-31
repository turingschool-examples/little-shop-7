namespace :csv_load do
  desc "TODO"
  task transactions: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join("db", "data", "transactions.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      #this is a transaction object that is being created, through the class, Transaction(our model)
      t = Transaction.new
      t.invoice_id = row["invoice_id"]
      t.credit_card_number = row["credit_card_number"]
      t.credit_card_expiration_date = row["credit_card_expiration_date"]
      t.result = row["result"]
      t.created_at = row["created_at"]
      t.updated_at = row["updated_at"]
      t.save
    end
  end
  puts "Seeded bro bro bro bro bro bro"
end
