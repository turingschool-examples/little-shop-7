namespace :csv_load do
  desc "Run multiple tasks"
  task all: ["customers", "invoice_items", "items", "merchants", "transactions"] do
  end
end