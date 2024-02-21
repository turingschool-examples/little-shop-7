require 'csv'

namespace :import do
    desc "Import customers from csv file"
    task customers: :environment do

    file = "db/data/customers.csv"
    
    CSV.foreach(file, headers: true) do |row|
        Customer.create(
        id: row['id'],
        first_name: row['first_name'],
        last_name: row['last_name'],
        created_at: DateTime.parse(row['created_at']),
        updated_at: DateTime.parse(row['updated_at'])
        )
    end

    end
end