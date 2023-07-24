namespace :csv_load do 
  desc "load merchants information"
  task csv_load [:merchants] do
    require "csv"
    CSV.foreach("/db/data", headers: true) do |merchant| 
      Merchant.create!(
      id: merchant["id"],
      name: merchant["name"], 
      created_at: merchant["created_at"],
      updated_at: merchant["updated_at"]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchant')
  end
end