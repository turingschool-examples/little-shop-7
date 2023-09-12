require "csv"



namespace :load_csv do
  task :customers => :environment do #team
    CSV.foreach("./db/data/customers.csv", headers: true, header_converters: :symbol) { |row| Customer.create(row) }
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
  task :customers => :environment do #Joop invoice_items
    CSV.foreach("./db/data/customers.csv", headers: true, header_converters: :symbol) { |row| Customer.create(row) }
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
  task :invoices => :environment do #Blake invoices
    CSV.foreach("./db/data/invoices.csv", headers: true, header_converters: :symbol) { |row| Invoice.create(row) }
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end
  task :customers => :environment do #Noelle items
    CSV.foreach("./db/data/customers.csv", headers: true, header_converters: :symbol) { |row| Customer.create(row) }
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
  task :customers => :environment do #Allan merchants
    CSV.foreach("./db/data/customers.csv", headers: true, header_converters: :symbol) { |row| Customer.create(row) }
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
  task :customers => :environment do #Noelle transactions
    CSV.foreach("./db/data/customers.csv", headers: true, header_converters: :symbol) { |row| Customer.create(row) }
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
  # task :customers => :environment do #Blake
  #   CSV.foreach("./db/data/customers.csv", headers: true, header_converters: :symbol) { |row| Customer.create(row) }
  #   ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  # end






end
