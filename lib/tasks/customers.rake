namespace :csv_load do 
  desc "load customer information"
  task csv_load [:customers] do
    CSV.foreach("/db/data", headers: true) do |customer| 
      Customer.create!(
      id: customer["id"],
      first_name: customer["first_name"], 
      last_name: customer["last_name"], 
      created_at: customer["created_at"],
      updated_at: customer["updated_at"]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end
end