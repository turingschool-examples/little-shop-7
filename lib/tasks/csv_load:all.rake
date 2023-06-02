require "csv"

namespace :csv_load do
  desc "Run all CSV Imports"
  task :all => :environment do
    
    
    Rake::Task["csv_load:customers"].invoke
    Rake::Task["csv_load:merchants"].invoke
    Rake::Task["csv_load:invoices"].invoke
    Rake::Task["csv_load:items"].invoke
    Rake::Task["csv_load:invoice_items"].invoke
    Rake::Task["csv_load:transactions"].invoke
    
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end
end