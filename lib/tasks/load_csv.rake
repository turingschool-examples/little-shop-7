require "csv"



namespace :load_csv do
  task :customers => :environment do
    contents = CSV.foreach("./db/data/customers.csv", headers: true, header_converters: :symbol) { |row| Customer.create(row) }
  #  binding.pry
  #  contents.each do |content| 
  #   first_name = content[:first_name],
  #   last_name = content[:last_name]
  #   Customer.create(first_name: first_name, last_name: last_name)
  #  end
  end
end
