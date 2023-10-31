namespace :csv_load do
  desc "Run multiple tasks"
  task all: [
    "customers",
    "invoice_items",
    "invoices",
    "items",
    "merchants",
    "transactions",
    "reset_primary_keys"
  ] do
  end
  puts "Seeded it all bro!"
end
