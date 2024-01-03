require "csv"

def importCSV(file_path, model)
  CSV.foreach(file_path, headers: true) { |row| model.create!(row.to_hash) }
end

# order of operations and relations matter when creating. parent classes must be made first
namespace :csv_load do
  desc "imports merchants csv into database"
  puts "Building merchant objects" 
  task :merchants => [:environment] do
    file_path = "db/data/merchants_test.csv"
    importCSV(file_path, Merchant)
  end
  
  desc "imports customers csv into database"
  puts "Building customer objects" 
  task :customers => [:environment] do
    file_path = "db/data/customer_test.csv"
    importCSV(file_path, Customer)
  end
  
  desc "imports items csv into database"
  puts "Building item objects" 
  task :items => [:environment] do
    file_path = "db/data/items_test.csv"
    importCSV(file_path, Item)
  end

  desc "imports invoices csv into database"
  puts "Building invoice objects" 
  task :invoices => [:environment] do
    file_path = "db/data/invoices_test.csv"
    importCSV(file_path, Invoice)
  end
  
  desc "imports tansactions csv into database"
  puts "Building tansaction objects" 
  task :tansactions => [:environment] do
    file_path = "db/data/transactions_test.csv"
    importCSV(file_path, Transaction)
  end
  
  desc "imports invoice_items csv into database"
  puts "Building invoice_item objects" 
  task :invoice_items => [:environment] do
    file_path = "db/data/invoice_items_test.csv"
    importCSV(file_path, InvoiceItem)
  end

  desc "imports all csv into database"
  task :all => [:environment] do
    table = ["merchants", "customers", "items", "invoices", "transactions", "invoice_items"]
    table.each { |t| Rake::Task["csv_load:#{t}"].invoke }
  end
end

# set up primary key squence 
desc 'Resets Postgres auto-increment ID column sequences to fix duplicate ID errors'
task :reset_sequences => :environment do
  Rails.application.eager_load!
  ActiveRecord::Base.descendants.each do |model|
    unless model.attribute_names.include?('id')
      Rails.logger.debug "Not resetting #{model}, which lacks an ID column"
      next
    end
    begin
      max_id = model.maximum(:id).to_i + 1
      result = ActiveRecord::Base.connection.execute(
        "ALTER SEQUENCE #{model.table_name}_id_seq RESTART #{max_id};"
      )
      Rails.logger.info "Reset #{model} sequence to #{max_id}"
    rescue => e
      Rails.logger.error "Error resetting #{model} sequence: #{e.class.name}/#{e.message}"
    end
  end
end