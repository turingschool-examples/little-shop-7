require 'csv'

namespace :csv_load do 

  desc "load customers"
  task customers: :environment do 
    #access CSV file
    file = "db/data/customers.csv"

    #parse CSV file
    CSV.foreach(file, headers: true) do |row|
      
      Customer.create(row.to_hash)
    end
      
      
      
      # { 
      #   id: row[0],
      #   first_name: row[1],
      #   last_name: row[2],
      #   created_at: row[3],
      #   updated_at: row[4]
      # }
    #convert data into models for db
    #reset pk sequence 
    
    # CSV.parse(File.read("db/data/customers.csv"), headers: true, header_converters: :symbol)
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