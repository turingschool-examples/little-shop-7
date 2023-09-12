namespace :csv_load do
  task :invoice_items => :environment do
    require 'csv'
    file_path = 'db/data/invoice_items.csv'
    CSV.foreach(file_path, headers: true) do |row|
      status = case row['status'].strip.downcase
      when 'shipped' 
        'shipped'
      when 'packaged'
        'packaged'
      when 'pending'
        'pending'
      else
        'pending'
      end
      InvoiceItem.create!(item_id: row['item_id'], invoice_id: row['invoice_id'], quantity: row['quantity'], unit_price: row['unit_price'], status: status, created_at: row['created_at'], updated_at: row['updated_at']) 
    end
  end
end
