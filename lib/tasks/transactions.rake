namespace :csv_load do 
  desc "load transactions information"
  task csv_load [:transactions] do
    require "csv"
    CSV.foreach("/db/data", headers: true) do |transaction| 
      Transaction.create!(
      id: transaction["id"],
      invoice_id: transaction["invoice_id"], 
      credit_card_number: transaction["credit_card_number"], 
      credit_card_expiration_date: transaction["credit_card_expiration_date"],
      result: transaction["result"],
      created_at: transaction["created_at"],
      updated_at: transaction["updated_at"]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end
end