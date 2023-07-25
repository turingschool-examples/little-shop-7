require 'csv'

namespace :csv_load do 

  desc "load customers"
  task customers: :environment do 
    #access CSV file
    file = "db/data/customers.csv"
    Customer.destroy_all
    #parse CSV file
    CSV.foreach(file, headers: true) do |row|
      #convert data into models for db
      Customer.create(row.to_hash)
    end
    #reset pk sequence 
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    puts "done"
  end
  
  desc "load invoice_items"
  task :invoice_items do 

  end

  desc "load invoices"
  task :invoices do 

  end

  desc "load items"
  task :items do 

  end

  desc "load merchants"
  task :merchants do 
  
  end
  
  desc "load transactions"
  task :transactions do 
  
  end

  desc "load all"
  task :all do 
    Rake::Task[]
  end

end



# desc "leafblower"
# task csv_load: [:merchants, :customers, :items, :invoices, :invoice_items, :transactions] do 


# end