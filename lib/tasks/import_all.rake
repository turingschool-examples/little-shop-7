namespace :csv_load do
  desc "Run multiple tasks"
  task all: [
    "customers",
    "merchants",
    "invoices",
    "items",
    "transactions",
    "invoice_items"
  ] do
  end
  puts "Seeded it all bro!"
end
