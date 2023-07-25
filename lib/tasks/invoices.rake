# namespace :csv_load do 
#   desc "load invoices information"
#   task csv_load [:invoices] do
#     require "csv"
#     CSV.foreach("/db/data", headers: true) do |invoice| 
#       Invoice.create!(
#       id: invoice["id"],
#       customer_id: invoice["customer_id"], 
#       quantity: invoice["quantity"], 
#       status: invoice["status"],
#       created_at: invoice["created_at"],
#       updated_at: invoice["updated_at"]
#       )
#     end
#     ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
#   end
# end
