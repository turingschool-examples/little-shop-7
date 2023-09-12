namespace :csv_load do
  task :invoices => :environment do
    require 'csv'
    file_path = 'db/data/invoices.csv'
    CSV.foreach(file_path, headers: true) do |row|
      status = case row['status'].strip.downcase
      when 'cancelled' 
        'cancelled'
      when 'completed'
        'completed'
      when 'in progress'
        'in progress'
      else
        'in progress'
      end
      Invoice.create!(customer_id: row['customer_id'], status: status, created_at: row['created_at'], updated_at: row['updated_at']) 
    end
  end
end