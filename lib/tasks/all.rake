require 'csv'

namespace :csv_load do
  desc "load customer.csv into database"
  task all: [:customers, :invoices, :transactions, :merchants, :items, :invoice_items]
end