namespace :csv_load do 
  desc "load invoice_items information"
  task csv_load [:invoice_items] do
    require "csv"
    CSV.foreach("/db/data", headers: true) do |invoice_item| 
      InvoiceItem.create!(
      id: invoice_item["id"],
      invoice_id: invoice_item["invoice_id"], 
      quantity: invoice_item["quantity"], 
      unit_price: invoice_item["unit_price"],
      status: invoice_item["status"],
      created_at: invoice_item["created_at"],
      updated_at: invoice_item["updated_at"]
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end
end