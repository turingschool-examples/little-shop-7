namespace :csv_load do 
  desc "load items information"
  task csv_load [:items] do
    require "csv"
    CSV.foreach("/db/data", headers: true) do |item| 
      Item.create!(
      id: item["id"],
      name: item["name"], 
      description: item["description"], 
      unit_price: item["unit_price"],
      merchant_id: item["merchant_id"],
      created_at: item["created_at"],
      updated_at: item["updated_at"]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end
end